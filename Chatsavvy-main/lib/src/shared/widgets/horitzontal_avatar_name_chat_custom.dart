// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
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
                  radius: 29,
                  child: Text(
                    name[0],
                    style: const TextStyle(fontSize: 25),
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
                      style: bodyBlack2,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text("2:40",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))
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
