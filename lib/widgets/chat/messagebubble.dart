import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMe,
    {required this.key}

     );

  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ 
      Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:isMe ? Colors.grey[300]: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(12)
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10
            ),
            margin: const EdgeInsets.symmetric(
              vertical:20,
              horizontal: 8
            ),
            child: Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                 Text(
                      username,
                      style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                Text(
                  message, 
                  style:  TextStyle( color: isMe? Colors.amber:Colors.black87),
                  textAlign: isMe? TextAlign.end:TextAlign.start,
                  )
              ],
            ),
          ),
        ],
      ),
       Positioned(
         top: 0,
         left: isMe ? null:120,
         right: isMe ? 120 : null,
         child: CircleAvatar(backgroundImage: NetworkImage(userImage),)
         )
      ],
    );
  }
}