// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillwise/src/models/my_user.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';
import 'package:pillwise/src/views/chat/chat_screen.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: primaryColor,
      duration: const Duration(seconds: 2),
      content: Text(
        content,
        style: bodyText2.copyWith(fontSize: 16),
      )));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return image;
}

Future<List<Contact>> getListOfContacts() async {
  List<Contact> contacts = [];
  try {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return contacts;
}

selectContact(BuildContext context, Contact selectedContact) async {
  try {
    var usersCollection =
        await FirebaseFirestore.instance.collection('users').get();
    bool isFound = false;
    for (var doc in usersCollection.docs) {
      var userData = MyUser.fromMap(doc.data());
      String selectedPhoneNumber =
          selectedContact.phones[0].number.replaceAll(" ", "");
      if (selectedPhoneNumber == userData.phone) {
        isFound = true;
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: userData);
      }
    }
    if (!isFound) {
      showSnackBar(context, "This contact isn't a user of Chatsavvy");
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
