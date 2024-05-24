import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String? username; // Make username parameter optional
  final bool isCurrentUser;

  const ChatBubble({
    Key? key,
    required this.message,
    this.username, // Make username parameter optional
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: isCurrentUser ? Colors.green : Colors.grey.shade500,
      ),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (username != null) // Only display username if it's not null
            Text(
              username!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(
              height: username != null
                  ? 4
                  : 0), // Add spacing if username is displayed
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
