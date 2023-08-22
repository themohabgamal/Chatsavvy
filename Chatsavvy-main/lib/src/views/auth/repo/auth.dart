// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pillwise/src/res/colors.dart';

class Auth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      Fluttertoast.showToast(
        msg: "Signed up successfuly",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Error : ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      Fluttertoast.showToast(
        msg: "Signed in successfuly",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Error : ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
      Fluttertoast.showToast(
        msg: "Signed out successfuly",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      return "${e.message}";
    }
  }
}
