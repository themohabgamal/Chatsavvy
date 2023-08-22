import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/models/my_message.dart';
import 'package:pillwise/src/models/my_user.dart';

class ChatViewModel extends ChangeNotifier {
  String? content;
  String roomId = '';
  String uId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController textController = TextEditingController();

  Future sendMessage() async {
    var userData = await FireStoreHelper().getUserFromDB(uId);
    var map = userData.data();
    var user = MyUser(
        id: map!["id"],
        name: map["name"],
        email: map["email"],
        imageUrl: map["image"],
        phone: map["phone"]);
    MyUser.currentUser = user;
    MyMessage message = MyMessage(
        content: content ?? "",
        messageId: '',
        senderName: user.name,
        senderId: FirebaseAuth.instance.currentUser!.uid,
        roomId: roomId,
        dateTime: DateTime.now().millisecondsSinceEpoch);
    await FireStoreHelper().addMessageToFireStore(message);
    textController.clear();
  }
}
