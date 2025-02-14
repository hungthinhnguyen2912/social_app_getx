import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/controller/auth_controller.dart';
import 'package:minimal_social_app_getx/controller/post_controller.dart';
import 'package:minimal_social_app_getx/view/component/MyDrawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy AuthController và PostController
    AuthController authController = Get.put(AuthController());
    PostController postController = Get.put(PostController());

    // Lấy thông tin user hiện tại
    User? currentUser = authController.getCurrentUser();

    if (currentUser == null) {
      return Scaffold(
        body: Center(child: Text("User is not logged in.")),
      );
    }

    // Gọi hàm lấy post theo email của user
    postController.getPostByEmail(currentUser.email!);

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(Icons.person, size: 100),
            SizedBox(height: 10),
            Text(
              currentUser.email!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Your Posts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (postController.postByEmail.isEmpty) {
                  return Center(child: Text("No posts found."));
                }
                return ListView.builder(
                  itemCount: postController.postByEmail.length,
                  itemBuilder: (context, index) {
                    final post = postController.postByEmail[index];
                    return ListTile(
                      title: Text(post.message),
                      subtitle: Text(post.timestamp.toDate().toString()),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
