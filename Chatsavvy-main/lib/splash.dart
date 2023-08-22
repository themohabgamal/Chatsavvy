import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillwise/root.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, Root.routeName));
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.asset('assets/images/gradient.png').image,
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash.png",
            width: 120,
            fit: BoxFit.fill,
          ),
          Text(
            "Chatsavvy",
            style: GoogleFonts.poppins(
                decoration: TextDecoration.none,
                textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )
        ],
      ),
    );
  }
}
