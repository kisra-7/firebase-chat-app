import 'package:flutter/material.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const MyChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isCurrentUser ? Colors.green : Colors.grey.shade500),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
