// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';

class HorizontalAvatarNameChat extends StatelessWidget {
  String name;
  String msg;
  HorizontalAvatarNameChat({
    Key? key,
    required this.name,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 29,
                  child: Text(
                    name[0],
                    style: bodyText3.copyWith(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: bodyBlack1,
                    ),
                    Text(
                      msg,
                      style: bodyBlack2.copyWith(
                          color: const Color.fromARGB(177, 0, 0, 0)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          color: Colors.black12,
          thickness: 2,
          indent: 70,
          endIndent: 70,
        )
      ],
    );
  }
}
