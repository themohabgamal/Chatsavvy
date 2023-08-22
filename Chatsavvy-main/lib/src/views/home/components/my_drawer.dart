// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';

class MyDrawer extends StatefulWidget {
  final String? name;
  final String? imageUrl;

  const MyDrawer({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: scaffoldColor,
      width: MediaQuery.of(context).size.width * 0.80,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.fill,
                    ).image,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(widget.name!, style: headline5),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title:
                const Text('My Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              // TODO: Implement My Profile screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              // TODO: Implement Settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title:
                const Text('About Us', style: TextStyle(color: Colors.white)),
            onTap: () {
              // TODO: Implement About Us screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Log Out', style: TextStyle(color: Colors.white)),
            onTap: () {
              // TODO: Implement Log Out functionality
            },
          ),
        ],
      ),
    );
  }
}
