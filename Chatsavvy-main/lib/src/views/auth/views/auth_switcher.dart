import 'package:flutter/material.dart';
import 'package:pillwise/src/views/auth/views/login/login_screen.dart';
import 'package:pillwise/src/views/auth/views/signup/signup_screen.dart';

class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({super.key});

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  bool isLogin = true;
  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(switchScreen: toggle);
    } else {
      return SignupScreen(switchScreen: toggle);
    }
  }
}
