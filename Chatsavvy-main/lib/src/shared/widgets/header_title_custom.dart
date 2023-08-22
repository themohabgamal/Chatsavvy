// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:pillwise/src/res/text_style.dart';

class HeaderTitleCustom extends StatelessWidget {
  String text;
  HeaderTitleCustom({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: headline5,
        ),
        const SizedBox(
          width: 35,
        ),
      ],
    );
  }
}
