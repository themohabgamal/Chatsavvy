// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/data/fire_store/profile.dart';
import 'package:pillwise/src/models/my_room.dart';
import 'package:pillwise/src/models/my_user.dart';

import 'package:pillwise/src/shared/widgets/header_title_custom.dart';
import 'package:pillwise/src/shared/widgets/horitzontal_avatar_name_chat_custom.dart';
import 'package:pillwise/src/views/add_room/add_room.dart';
import 'package:pillwise/src/views/chat/chat_screen.dart';
import 'package:pillwise/src/views/home/components/my_drawer.dart';
import 'package:pillwise/src/views/home/views/home_navigator.dart';
import 'package:pillwise/src/views/home/views/home_view_model.dart';
import 'package:pillwise/src/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator {
  HomeViewModel homeViewModel = HomeViewModel();
  String? name;
  String? imageUrl;
  late MyUser myUser;
  @override
  void initState() {
    Future<MyUser> user = retriveUserData();
    user.then(
      (value) {
        setState(() {
          myUser = value;
          name = value.name;
          imageUrl = value.image;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: Scaffold(
        extendBody: true,
        key: homeViewModel.scaffoldKey,
        drawer: MyDrawer(
          name: name,
          imageUrl: imageUrl,
        ),
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, right: 20, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            homeViewModel.drawerState();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          )),
                      Image.asset(
                        "assets/images/notification.png",
                        width: 28,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                      padding: const EdgeInsets.only(left: 15),
                      scrollDirection: Axis.horizontal,
                      children: [
                        HeaderTitleCustom(
                          text: "Messages",
                        ),
                        HeaderTitleCustom(
                          text: "Online",
                        ),
                        HeaderTitleCustom(
                          text: "Groups",
                        ),
                        HeaderTitleCustom(
                          text: "Other",
                        ),
                      ]),
                )
              ],
            ),
            Positioned(
                top: 200,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: StreamBuilder<QuerySnapshot<MyRoom>>(
                      stream: FireStoreHelper().getRoomsList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error : ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          List<MyRoom> roomList = snapshot.data!.docs
                              .map((doc) => doc.data())
                              .toList();
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                            child: ListView.builder(
                              itemCount: roomList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, ChatScreen.routeName,
                                      arguments: roomList[index]),
                                  child: HorizontalAvatarNameChat(
                                    name: roomList[index].name,
                                    msg: roomList[index].description,
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )))
          ],
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/group.png",
                  width: 32,
                ),
              ),
              InkWell(
                onTap: () {
                  navigateToCreateRoomScreen();
                },
                child: Image.asset(
                  "assets/images/add.png",
                  width: 30,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName,
                      arguments: myUser);
                },
                child: Image.asset(
                  "assets/images/profile.png",
                  width: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  navigateToCreateRoomScreen() {
    Navigator.pushNamed(context, CreateNewRoom.routeName);
  }
}
