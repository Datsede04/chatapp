import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.
            collection("chat/6Cdckx0sjMg4cnbL7ek2/message")
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator()
              );
          }

          final documents = snapshot.data!.docs;
          return snapshot.hasData? ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx,index)=>  Container(
              padding: const EdgeInsets.all(10),
              child: Text(documents[index]['text']),
             )
            ):
            const Center(
              child:Text("No data")
            );
        }
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance.collection("chat/6Cdckx0sjMg4cnbL7ek2/message").
            add({"text":"The button have been clicked"});
              }
            ) 
         );
        }
  }
