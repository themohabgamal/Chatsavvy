// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/src/views/auth/views/auth_switcher.dart';
import 'package:pillwise/src/views/home/views/home_screen.dart';

class Root extends StatelessWidget {
  static const String routeName = 'root';
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const AuthSwitcher();
            }
          }),
    );
  }
}
