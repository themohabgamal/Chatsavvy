import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/views/add_room/add_room_navigator.dart';
import 'package:pillwise/src/views/add_room/add_room_view_model.dart';
import 'package:provider/provider.dart';

class CreateNewRoom extends StatefulWidget {
  static const String routeName = 'createnewRoom';
  @override
  _CreateNewRoomState createState() => _CreateNewRoomState();
}

class _CreateNewRoomState extends State<CreateNewRoom>
    implements AddRoomNavigator {
  AddRoomViewModel addRoomViewModel = AddRoomViewModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    addRoomViewModel.addRoomNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => addRoomViewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text('Create New Room'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) {
                  addRoomViewModel.name = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter name',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  await addRoomViewModel.createRoom();
                  Fluttertoast.showToast(msg: "Room Created");
                  addRoomViewModel.addRoomNavigator.navigateToHome();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(fontSize: 18),
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
