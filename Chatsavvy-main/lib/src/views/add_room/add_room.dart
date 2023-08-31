import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';
import 'package:pillwise/src/views/add_room/add_room_navigator.dart';
import 'package:pillwise/src/views/add_room/add_room_view_model.dart';
import 'package:provider/provider.dart';

class CreateNewRoom extends StatefulWidget {
  static const String routeName = 'createnewRoom';

  const CreateNewRoom({super.key});
  @override
  CreateNewRoomState createState() => CreateNewRoomState();
}

class CreateNewRoomState extends State<CreateNewRoom>
    implements AddRoomNavigator {
  AddRoomViewModel addRoomViewModel = AddRoomViewModel();
  @override
  void initState() {
    super.initState();
    addRoomViewModel.addRoomNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => addRoomViewModel,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            'Create New Room',
            style: headline4.copyWith(fontSize: 28, color: Colors.white),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Stack(
            children: [
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Name',
                      style:
                          headline4.copyWith(fontSize: 22, color: Colors.black),
                    ),
                    TextField(
                      onChanged: (value) {
                        if (value == "") {
                          return;
                        }
                        addRoomViewModel.name = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description',
                      style:
                          headline4.copyWith(fontSize: 22, color: Colors.black),
                    ),
                    TextField(
                      onChanged: (value) {
                        addRoomViewModel.description = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter description',
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (addRoomViewModel.description == "" ||
                            addRoomViewModel.name == "") {
                          Fluttertoast.showToast(
                              msg: "Name or Description can't be empty",
                              fontSize: 18);

                          return;
                        }
                        await addRoomViewModel.createRoom();

                        Fluttertoast.showToast(
                            msg: "Room Created",
                            fontSize: 18,
                            backgroundColor: Colors.blue);
                        addRoomViewModel.addRoomNavigator.navigateToHome();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Create',
                        style: headline4.copyWith(
                            fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  navigateToHome() {
    Navigator.pop(context);
  }
}
