import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/controller/chat_controller.dart';
import 'package:minimal_social_app_getx/model/message_model.dart';
import 'package:minimal_social_app_getx/view/component/Chat_bubble.dart';
import 'package:minimal_social_app_getx/view/component/MyTextField.dart';

class ChatDetailPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId; // Thêm ID của người nhận
  ChatDetailPage({super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController chatController = TextEditingController();
  final ChatController _getx = Get.put(ChatController()); // Sử dụng GetX để quản lý trạng thái

  @override
  Widget build(BuildContext context) {
    // Gọi hàm lấy tin nhắn khi vào màn hình chat
    _getx.getMessages(receiverId);

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()), // Hiển thị danh sách tin nhắn
          _buildUserInput(), // Ô nhập tin nhắn
        ],
      ),
    );
  }

  // 🟢 Hiển thị danh sách tin nhắn từ Firestore
  Widget _buildMessageList() {
    return Obx(() => ListView.builder(
      reverse: true, // Để tin nhắn mới nhất ở dưới cùng
      itemCount: _getx.messages.length,
      itemBuilder: (context, index) {
        final Message msg = _getx.messages[index];
        final bool isCurrentUser = msg.senderId == _getx.auth.currentUser!.uid;
        return chat_bubble(message: msg.message, isCurrentUser: isCurrentUser);
      },
    ));
  }

  // 🔵 Ô nhập tin nhắn
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  hintText: 'Nhập tin nhắn...',
                  obscureText: false,
                  controller: chatController)),
          IconButton(
              onPressed: () {
                _sendMessage();
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }

  // 🟡 Hàm gửi tin nhắn
  void _sendMessage() {
    if (chatController.text.trim().isNotEmpty) {
      _getx.sendMessage(receiverId, chatController.text.trim());
      chatController.clear(); // Xóa nội dung sau khi gửi
    }
  }
}
