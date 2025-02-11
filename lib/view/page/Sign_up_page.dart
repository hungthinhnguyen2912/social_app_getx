import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/controller/auth_controller.dart';
import 'package:minimal_social_app_getx/view/page/Home_screen_page.dart';
import 'package:minimal_social_app_getx/view/page/Log_in_page.dart';
import '../../constants.dart';
import '../component/MyTextField.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController),
            SizedBox(
              height: 20,
            ),
            MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController),
            SizedBox(
              height: 20,
            ),
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passController),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                authController.Register(passController.text, emailController.text, usernameController.text);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: buttonColor,
                child: Center(
                  child: Text('Sign up'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have account ?'),
                TextButton(
                    onPressed: () {
                      Get.to(LogInPage());
                    },
                    child: Text('Log in here'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
