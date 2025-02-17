import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/model/message_model.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var messages = <Message>[].obs;

  void getMessages(String otherUserId) {
    if (auth.currentUser == null) return;
    final String currentUserId = auth.currentUser!.uid;
    List<String> ids = [currentUserId, otherUserId]..sort();
    String chatRoomId = ids.join('_');

    messages.bindStream(
      _firestore
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('message')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return Message.fromMap(data);
        }).toList();
      }),
    );
  }

  // 🟢 Gửi tin nhắn
  Future<void> sendMessage(String receiverId, String message) async {
    if (auth.currentUser == null) return;
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserID,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserID, receiverId]..sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
  }
}
