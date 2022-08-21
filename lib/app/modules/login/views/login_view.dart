import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff609DFF),
              Color(0xff8E2EFF),
            ],
            // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 270,
            child: Column(
              children: [
                Text('여행 계획과 동행 찾기를 한번에',style: TextStyle(color: Colors.white),),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                        child: Image(image: AssetImage('assets/image/bird.png'))),
                    SizedBox(
                      width: 260,
                        child: Image(image: AssetImage('assets/image/logo.png'))),
                  ],
                ),
                SizedBox(height: 100,),
                Container(
                  height: 50,
                  width: 220,
                  child: SignInButton(
                    Buttons.Google,
                    text: "      구글로 로그인",
                    onPressed: controller.signIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
