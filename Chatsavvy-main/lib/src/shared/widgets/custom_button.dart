// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pillwise/src/res/colors.dart';

class CustomButton extends StatelessWidget {
  final Function function;
  final String text;
  const CustomButton({
    Key? key,
    required this.function,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
