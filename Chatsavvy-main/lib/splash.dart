// ignore_for_file: use_build_context_synchronously, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillwise/root.dart';
import 'package:pillwise/src/views/on_boarding/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  loadWidget() {
    return Timer(const Duration(seconds: 2), () {
      checkFirstSeen();
    });
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introSeen = (prefs.getBool('intro_seen') ?? false);

    Navigator.pop(context);
    if (introSeen) {
      Navigator.pushNamed(context, Root.routeName);
    } else {
      await prefs.setBool('intro_seen', true);
      Navigator.pushNamed(context, OnBoardingScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/gradient.png'), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash.png",
            width: 140,
            fit: BoxFit.fill,
          ),
          Text(
            "Chatsavvy",
            style: GoogleFonts.poppins(
                decoration: TextDecoration.none,
                textStyle: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )
        ],
      ),
    );
  }
}
