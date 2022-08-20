import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          child: SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: controller.signIn,
          ),
        )
      ),
    );
  }
}
