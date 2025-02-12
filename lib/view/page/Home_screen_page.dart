import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/constants.dart';
import 'package:minimal_social_app_getx/controller/post_controller.dart';
import 'package:minimal_social_app_getx/view/component/MyDrawer.dart';
import 'package:minimal_social_app_getx/view/component/MyTextField.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostController _postControllerGetX = Get.put(PostController());
    TextEditingController postControllerTextField = TextEditingController();
    _postControllerGetX.getPost();
    return Scaffold(
      appBar: AppBar(
        title: Text('H O M E'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
                hintText: "Enter what are you thinking",
                obscureText: false,
                controller: postControllerTextField),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (postControllerTextField.text == "") {
                  Get.snackbar("No data in text field", "Please enter your content");
                } else {
                _postControllerGetX.addPost(postControllerTextField.text);
                postControllerTextField.clear();
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: buttonColor),
                child: Center(child: Text("Post")),
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: _postControllerGetX.posts.length,
                    itemBuilder: (context, index) {
                      final post = _postControllerGetX.posts[index];
                      return ListTile(
                        title: Text(post.message),
                        subtitle: Text(post.email),
                        // trailing: Text(post.timestamp.toString()),
                      );
                    });
              }),
            )
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
