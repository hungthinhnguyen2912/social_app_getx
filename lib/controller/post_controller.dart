import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/constants.dart';
import 'package:minimal_social_app_getx/model/post_model.dart';

class PostController extends GetxController {
  User? user = firebaseAuth.currentUser;
  var posts = [].obs;
  var postByEmail = [].obs;
  Future<void> addPost(String message) async {
    User? user = firebaseAuth.currentUser;
    Post newPost =
        Post(email: user!.email!, message: message, timestamp: Timestamp.now());
    await firestore.collection("posts").doc(user!.email!).set(newPost.toMap());
    posts.add(newPost);
  }

  Future<void> getPost() async {
    QuerySnapshot snapshot = await firestore
        .collection("posts")
        .orderBy("timestamp", descending: true)
        .get();
    posts.value = snapshot.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
  Future<void> getPostByEmail (String email) async {
    QuerySnapshot snapshot = await firestore
        .collection("posts")
        .where("email",isEqualTo: email)
        .get();
    postByEmail.value = snapshot.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
 }
