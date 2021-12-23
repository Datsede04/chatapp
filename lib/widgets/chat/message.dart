import 'package:chatapp/widgets/chat/messagebubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt').snapshots(),
      builder: (ctx,chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator()
            );
        }
      
        final chatDocs = chatSnapshot.data!.docs;
        return chatDocs.isEmpty ?const Center(child: Text("No chat yet")) :ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index)=>
          MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['username'],
            chatDocs[index]['userImage'],
            chatDocs[index]['userId']== FirebaseAuth.instance.currentUser!.uid,
            key:ValueKey(chatDocs[index].id))
          );
      },

    );
  }
}