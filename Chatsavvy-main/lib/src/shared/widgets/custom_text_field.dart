import 'package:flutter/material.dart';
import 'package:pillwise/src/res/text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String helperText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        style: bodyText2.copyWith(
            color: const Color.fromARGB(199, 0, 0, 0),
            fontWeight: FontWeight.w600,
            fontSize: 20),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
          labelText: helperText,
          labelStyle: bodyText1.copyWith(color: Colors.grey),
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
