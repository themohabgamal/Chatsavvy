// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pillwise/src/data/fire_store/profile.dart';
import 'package:pillwise/src/models/my_user.dart';

import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';
import 'package:pillwise/src/views/about_us/about_us_screen.dart';
import 'package:pillwise/src/views/profile/profile_screen.dart';

import '../../auth/repo/auth.dart';

class MyDrawer extends StatefulWidget {
  final String? name;
  final String? imageUrl;

  const MyDrawer({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  MyUser? myUser;
  @override
  void initState() {
    Future<MyUser> user = retriveUserData();
    user.then(
      (value) {
        setState(() {
          myUser = value;
        });
      },
    );
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: scaffoldColor,
      width: MediaQuery.of(context).size.width * 0.80,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: Image.network(
                      myUser?.image ??
                          "https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png",
                      fit: BoxFit.fill,
                    ).image,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(myUser?.name ?? "",
                    style: headline5.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.white)),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title:
                const Text('My Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title:
                const Text('About Us', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushNamed(context, AboutUsScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Log Out', style: TextStyle(color: Colors.white)),
            onTap: () {
              Auth().signOut();
            },
          ),
        ],
      ),
    );
  }
}
