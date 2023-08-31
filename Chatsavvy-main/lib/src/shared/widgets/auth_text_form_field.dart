// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:pillwise/src/res/colors.dart';

class AuthTextFormField extends StatelessWidget {
  String? hintText;
  bool secureText;
  int? maxLength;
  TextEditingController controller;
  IconData? icon;
  Color color;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  AuthTextFormField({
    Key? key,
    this.hintText,
    this.onSaved,
    required this.secureText,
    this.maxLength,
    required this.controller,
    this.icon,
    required this.color,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
      cursorColor: primaryColor,
      showCursor: true,
      maxLength: maxLength,
      decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
          counterStyle: const TextStyle(color: Colors.white),
          focusColor: primaryColor,
          hintStyle: const TextStyle(color: Colors.white),
          fillColor: color,
          filled: true,
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          )),
      validator: validator,
      controller: controller,
      obscureText: secureText,
      onSaved: onSaved,
    );
  }
}
