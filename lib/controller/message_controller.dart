import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var users = <Map<String, dynamic>>[].obs;

  @override
  void onInit () {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection("users").get();
      users.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Lỗi khi lấy danh sách users: $e");
    }
  }
}