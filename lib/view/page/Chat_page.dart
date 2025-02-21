import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/controller/message_controller.dart';
import 'package:minimal_social_app_getx/view/component/MyDrawer.dart';
import 'package:minimal_social_app_getx/view/page/Chat_detail_page.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final UserController userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (userController.users.isEmpty) {
                  return Center(child: Text("No user founded"),);
                }
                return ListView.builder(
                    itemCount: userController.users.length,
                    itemBuilder: (context,index) {
                  var user = userController.users[index];
                  return ListTile(
                    onTap: () {
                      Get.to(ChatDetailPage(receiverEmail: user['email'], receiverId: user['uid']));
                    },
                    title: Text(user['email']),
                    subtitle: Text(user['name']),
                  );
                });
              }),
            )
          ],
        ),
      ),
      drawer: MyDrawer(namePage: 'ChatPage',),
    );
  }
}
