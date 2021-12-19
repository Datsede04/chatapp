import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12)
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10
          ),
          margin: const EdgeInsets.symmetric(
            vertical:4,
            horizontal: 8
          ),
          child: Text(message, style: const TextStyle(color: Colors.black87),),
        ),
      ],
    );
  }
}