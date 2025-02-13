import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/controller/message_controller.dart';
import 'package:minimal_social_app_getx/view/page/Chat_detail_page.dart';
class ChatPage extends StatelessWidget {
  MessageController messageController = Get.put(MessageController());
  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if(messageController.isLoading.value == true) {
                return Center(child: CircularProgressIndicator(),);
              } else {
                return ListView.builder(
                    itemCount: messageController.users.length,
                    itemBuilder: (context,index) {
                      var user = messageController.users[index];
                      return ListTile(
                        onTap: () {
                          Get.to(() => ChatDetailPage(EmailReceiver: user['email'], ReceiverID: user['uid'],));
                        },
                        title: Text(user['name'] ?? 'Không có tên'),
                        subtitle: Text(user['email'] ?? 'Không có email'),
                      );
                    });
              }
            }),
          )
        ],
      ),
    );
  }
}
