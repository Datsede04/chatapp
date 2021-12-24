import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage();

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  final _controller = TextEditingController();
  var _enterdMessage ="";
  
  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData= await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
   
  await FirebaseFirestore.instance.collection('chat').add({
      "text":_enterdMessage,
      "createdAt":Timestamp.now(),
      "userId":user.uid,
      "username": userData.data()!['username'].toString(),
      "userImage" : userData.data()!['image_url'].toString(),
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top: 8),
      margin :const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: "send a message ...."),
              onChanged: (value){
                setState(() {
                  _enterdMessage =value;
                });
              },
            )
          ),
          IconButton(
            onPressed: _enterdMessage.trim().isEmpty?null: _sendMessage, 
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            ),
        ],
      ),

    );
  }
}