// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/src/data/database/firebase_storage._helper.dart';
import 'package:pillwise/src/shared/utils/utils.dart';

import 'package:pillwise/src/shared/widgets/auth_text_form_field.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/models/my_user.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/shared/widgets/custom_button.dart';
import 'package:pillwise/src/views/auth/repo/auth.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup';
  final Function() switchScreen;

  const SignupScreen({
    Key? key,
    required this.switchScreen,
  }) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? imageUrl;
  File? image;
  Future<File?> selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
    return image;
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      imageUrl == null
                          ? InkWell(
                              onTap: () => onUpload(),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: Image.asset(
                                        "assets/images/user.png",
                                        fit: BoxFit.fill,
                                      ).image,
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Colors.white),
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 120,
                              height: 120,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: Image.network(
                                  imageUrl!,
                                  fit: BoxFit.fill,
                                ).image,
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        color: scaffoldColor,
                        hintText: 'Name',
                        secureText: false,
                        controller: _nameController,
                        icon: Icons.perm_identity,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name can't be empty";
                          }
                          return null;
                        },
                      ),
                      AuthTextFormField(
                        color: scaffoldColor,
                        hintText: 'Phone',
                        secureText: false,
                        controller: _phoneController,
                        icon: Icons.phone_android_rounded,
                        validator: (value) {
                          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Please enter mobile number';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },
                      ),
                      AuthTextFormField(
                        color: scaffoldColor,
                        hintText: 'Email',
                        secureText: false,
                        controller: _emailController,
                        icon: Icons.alternate_email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email can't be empty";
                          }
                          return null;
                        },
                      ),
                      AuthTextFormField(
                        color: scaffoldColor,
                        hintText: "Password",
                        secureText: true,
                        controller: _passwordController,
                        icon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                          width: double.infinity,
                          child: CustomButton(function: auth, text: "Sign Up")),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already a user?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          // Add some space between the text and the button
                          TextButton(
                            onPressed: () {
                              widget.switchScreen();
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void auth() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await Auth().signUp(_emailController.text, _passwordController.text);
      MyUser user = MyUser(
          id: FirebaseAuth.instance.currentUser!.uid,
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          imageUrl: imageUrl!,
          phone: _phoneController.text.trim());
      await FireStoreHelper().addUserToDB(user);
    }
  }

  onUpload() async {
    await selectImage();
    imageUrl = await FirebaseStorageHelper().addImageToDB(image);
    setState(() {});
  }
}
