// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:pillwise/src/shared/widgets/auth_text_form_field.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/shared/widgets/custom_button.dart';
import 'package:pillwise/src/views/auth/views/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  final Function() switchScreen;

  const LoginScreen({
    Key? key,
    required this.switchScreen,
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => loginViewModel,
      child: Scaffold(
        backgroundColor: scaffoldColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/images/chatting.png",
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 30),
                  Form(
                    key: loginViewModel.formKey,
                    child: Column(
                      children: [
                        AuthTextFormField(
                            color: scaffoldColor,
                            hintText: 'Email',
                            secureText: false,
                            controller: loginViewModel.emailController,
                            icon: Icons.alternate_email),
                        const SizedBox(height: 20),
                        AuthTextFormField(
                            color: scaffoldColor,
                            hintText: "Password",
                            secureText: true,
                            controller: loginViewModel.passwordController,
                            icon: Icons.lock),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                                function: loginViewModel.signIn,
                                text: "Login")),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'not a user?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            // Add some space between the text and the button
                            TextButton(
                              onPressed: () {
                                widget.switchScreen();
                              },
                              child: const Text(
                                'Sign up',
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
      ),
    );
  }
}
