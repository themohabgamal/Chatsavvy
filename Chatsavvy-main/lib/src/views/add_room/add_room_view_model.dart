import 'package:flutter/cupertino.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/models/my_room.dart';
import 'package:pillwise/src/views/add_room/add_room_navigator.dart';

class AddRoomViewModel extends ChangeNotifier {
  String name = '';
  String description = '';
  late AddRoomNavigator addRoomNavigator;
  createRoom() async {
    MyRoom room = MyRoom(name: name, description: description, roomId: "");
    await FireStoreHelper().createNewRoomToFireStore(room);
  }
}
