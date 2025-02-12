import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String email;
  final String message;
  final Timestamp timestamp;

  Post({required this.email, required this.message, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'message': this.message,
      'timestamp': this.timestamp,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      email: map['email'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
