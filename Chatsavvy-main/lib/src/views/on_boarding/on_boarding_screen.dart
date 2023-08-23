import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pillwise/root.dart';
import 'package:pillwise/src/res/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = 'boarding';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,

      pages: [
        PageViewModel(
          decoration: const PageDecoration(
              bodyAlignment: Alignment.bottomCenter, imageFlex: 4),
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: Image.asset(
            'assets/images/1.png',
            width: 400,
          ),
        ),
        PageViewModel(
          decoration: const PageDecoration(
              bodyAlignment: Alignment.bottomCenter, imageFlex: 4),
          title: "Learn as you go",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: Image.asset(
            'assets/images/2.png',
            width: 400,
          ),
        ),
        PageViewModel(
          decoration: const PageDecoration(
              bodyAlignment: Alignment.bottomCenter, imageFlex: 4),
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: Image.asset(
            'assets/images/3.png',
            width: 400,
          ),
        ),
      ],
      onDone: () => Navigator.pushReplacementNamed(context, Root.routeName),
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeColor: Colors.white,
        activeSize: Size(33.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
