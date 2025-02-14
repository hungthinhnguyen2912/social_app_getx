import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senderId,
        required this.senderEmail,
        required this.receiverId,
        required this.message,
        required this.timestamp});
  // Convert to Map or Json
  Map<String,dynamic> toMap () {
    return {
      'senderId' : senderId,
      'senderEmail' : senderEmail,
      'receiverId' : receiverId,
      'message' : message,
      'timestamp' : timestamp
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}