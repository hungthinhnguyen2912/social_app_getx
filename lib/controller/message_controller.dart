import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/model/message_model.dart';

class MessageController extends GetxController {
  var users = <Map<String, dynamic>>[].obs;

  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = true.obs;
  var messages = <QueryDocumentSnapshot>[].obs;
  RxBool? isCurrentUser;

  @override
  void onInit () {
    super.onInit();
    fetchUser();
  }
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
  void getMessages(String otherUserId) {
    final String currentUserId = _auth.currentUser!.uid;
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs;
    });
  }
  Future <void> fetchUser() async {
    isLoading(true);
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      // Cập nhật danh sách users
      users.value =
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
      isLoading(false);
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
    }
  }
}

