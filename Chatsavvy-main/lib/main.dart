import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/root.dart';
import 'package:pillwise/splash.dart';
import 'package:pillwise/src/views/add_room/add_room.dart';
import 'package:pillwise/src/views/chat/chat_screen.dart';
import 'package:pillwise/src/views/home/views/home_screen.dart';
import 'package:pillwise/src/views/on_boarding/on_boarding_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatsavvy',
      routes: {
        Root.routeName: (context) => const Root(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CreateNewRoom.routeName: (context) => const CreateNewRoom(),
        ChatScreen.routeName: (context) => const ChatScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
