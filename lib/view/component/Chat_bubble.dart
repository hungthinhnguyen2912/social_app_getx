import 'package:flutter/material.dart';

class chat_bubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  chat_bubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCurrentUser ? Colors.blueAccent : Colors.grey[300],
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16, color: isCurrentUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
