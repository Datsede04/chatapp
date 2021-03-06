import 'package:chatapp/widgets/chat/message.dart';
import 'package:chatapp/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("chat app"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: const Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                
                child: Container(
                child: Row(
                children: const <Widget>[
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8,),
                  Text("Logout")
                ], 
              ),
            ),
          value: "logout",
            )
            ],

           onChanged: (itemIdentifier){
             if(itemIdentifier == 'logout'){
               FirebaseAuth.instance.signOut();
             }
           }, 
            )
          ],
      ),
      body: Column(
        children: const <Widget>[
         Expanded(
           child: Message()
           ),
         NewMessage(),  
        ],
      ),
         );
        }
}
