import 'package:flutter/cupertino.dart';
import 'package:pillwise/src/views/auth/repo/auth.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await Auth().signIn(emailController.text, passwordController.text);
    }
  }
}
