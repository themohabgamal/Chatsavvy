// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:pillwise/src/res/text_style.dart';

class VerticalAvatarNameCustom extends StatelessWidget {
  String name;
  String imgName;
  VerticalAvatarNameCustom({
    Key? key,
    required this.name,
    required this.imgName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 33,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 29,
                backgroundImage: Image.asset("assets/images/$imgName").image,
              ),
            ),
            Text(
              name,
              style: bodyText2,
            )
          ],
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}
