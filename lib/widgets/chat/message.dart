import 'package:chatapp/widgets/chat/messagebubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt').snapshots(),
      builder: (ctx,chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }

        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index)=>
          MessageBubble(chatDocs[index]['text']));
      },

    );
  }
}