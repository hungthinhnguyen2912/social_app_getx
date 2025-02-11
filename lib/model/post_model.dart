import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String email;
  final String message;
  final Timestamp timestamp;

  Post({required this.email, required this.message, required this.timestamp});
}
