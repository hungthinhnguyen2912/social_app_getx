import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/constants.dart';
import 'package:minimal_social_app_getx/controller/auth_controller.dart';
import 'package:minimal_social_app_getx/view/component/MyDrawer.dart';
import 'package:minimal_social_app_getx/view/component/MyTextField.dart';
import 'package:minimal_social_app_getx/view/page/Home_screen_page.dart';
import 'package:minimal_social_app_getx/view/page/Sign_up_page.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController),
            SizedBox(height: 20,),
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passController),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                authController.LogIn(passController.text, emailController.text);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: buttonColor,
                child: Center(
                  child: Text('Log in'),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New User ?'),
                TextButton(onPressed: () {
                  Get.to(SignUpPage());
                }, child: Text('Sign up here'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
