import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/model/message_model.dart';

class MessageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Gửi tin nhắn
  Future<void> sendMessage(String message, String receiverId) async {
    try {
      final Timestamp timestamp = Timestamp.now();
      final String currentUserId = _auth.currentUser!.uid;
      final String currentUserEmail = _auth.currentUser!.email!;

      Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
      );

      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      await _firestore
          .collection("chat_room")
          .doc(chatRoomId)
          .collection("message")
          .add(newMessage.toMap());
    } catch (e) {
      print("Error sending message: $e");
    }
  }
  // Lấy danh sách tin nhắn
  Stream<QuerySnapshot> getMessages(String otherUserId) {
    final String currentUserId = _auth.currentUser!.uid;
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    var data = _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return data;
  }
}
