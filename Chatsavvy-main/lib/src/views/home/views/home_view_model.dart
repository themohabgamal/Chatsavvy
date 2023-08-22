import 'package:flutter/material.dart';
import 'package:pillwise/src/views/auth/repo/auth.dart';
import 'package:pillwise/src/views/home/views/home_navigator.dart';

class HomeViewModel extends ChangeNotifier {
  late HomeNavigator homeNavigator;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  drawerState() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
      //close drawer, if drawer is open
    } else {
      scaffoldKey.currentState!.openDrawer();
      //open drawer, if drawer is closed
    }
  }

  signOut() {
    Auth().signOut();
  }
}
