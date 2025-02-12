import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/constants.dart';
import 'package:minimal_social_app_getx/view/page/Home_screen_page.dart';
import 'package:minimal_social_app_getx/view/page/Log_in_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  void LogIn (String password,String email) async {
    try {
        if(email.isNotEmpty && password.isNotEmpty) {
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          Get.snackbar("Log in success", " ");
          Get.to(HomeScreenPage());
        } else {
          Get.snackbar("Error log in", "Please enter all field");
        }
    } on FirebaseAuthException catch (e) {
          Get.snackbar("Error log in", e.toString());
    }
  }
  Future<User?> Register (String password,String email, String username) async {
    try {
      if (password.isNotEmpty && email.isNotEmpty && username.isNotEmpty) {
        UserCredential userCredential ;
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        User user = userCredential.user!;
        await firestore.collection("users").doc(user.uid).set({
          "name" : username,
          "email" : email,
          "uid" : user.uid
        });
        Get.snackbar("Create user in firebasefirestore", "");
        if(user != null) {
          Get.off(HomeScreenPage());
        } else {
          Get.snackbar("Error", "Some thing went wrong");
        }
        return user;
      }
    } catch (e) {
      Get.snackbar("Error register", e.toString());
      return null;
    }
  }
  void LogOut () async {
    await firebaseAuth.signOut();
    Get.to(LogInPage());
  }
  User getCurrentUser () {
    User user = firebaseAuth.currentUser!;
    return user;
  }

}