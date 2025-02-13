import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/controller/message_controller.dart';
import 'package:minimal_social_app_getx/view/component/Chat_bubble.dart';
import 'package:minimal_social_app_getx/view/component/MyTextField.dart';

class ChatDetailPage extends StatelessWidget {
  final String EmailReceiver;
  final String ReceiverID;
  TextEditingController messageControllerTextField = TextEditingController();

  ChatDetailPage(
      {super.key, required this.EmailReceiver, required this.ReceiverID});
  MessageController messageController = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {

    void sendMessage() {
      if (messageControllerTextField.text.isNotEmpty) {
        messageController.sendMessage(
            messageControllerTextField.text, ReceiverID);
        messageControllerTextField.clear();
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(EmailReceiver),
        ),
        body: Column(
          children: [
            Row(
              children: [
                MyTextField(
                    hintText: "Enter message",
                    obscureText: false,
                    controller: messageControllerTextField),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(Icons.arrow_forward_outlined))
              ],
            ),
            Expanded(
              child: _buildMessageList()
            )
          ],
        ));
  }
  Widget _buildMessageList() {
    return Obx(() {
      if (messageController.messages.isEmpty) {
        return Center(child: Text("Chưa có tin nhắn nào"));
      }
      return ListView.builder(
          itemCount: messageController.messages.length,
          itemBuilder: (context, index) {
            return chat_bubble(messsage: messageControllerTextField.text, isCurrentUser: true,);
          });
    });
  }
}
