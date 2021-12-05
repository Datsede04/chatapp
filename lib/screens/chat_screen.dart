import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx,index)=>  Container(
          padding: const EdgeInsets.all(10),
          child: const Text("This works"),
         )
        ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
             
           FirebaseFirestore.instance.
            collection("chat/6Cdckx0sjMg4cnbL7ek2/message")
            .snapshots()
            .listen((data) {
               data.docs.forEach((element) {
                print(element["text"]);
               });
            });
              }
            ) 
         );
        }
  }
