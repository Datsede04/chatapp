import 'dart:io';

import 'package:chatapp/widgets/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
   const AuthForm(this.submfn,this.isLoading);

  final bool isLoading; 
  final void Function 
   (
     String email,
     String password,
     String username,
     File userImage,
     bool isLogin,
     BuildContext ctx
   ) submfn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
   final _formKey = GlobalKey<FormState>();
   var _isLogin  = true;
   String _username ='';
   String _useremail='';
   String _userpassword=''; 
   File ?_userImageFile;

  void _pickedImage(File image){
        _userImageFile= image;
  }

   void _trySubmiti(){
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus(); //to close the keybore 
      
      if(_userImageFile == null && !_isLogin ){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("please select image"),
                duration: Duration(milliseconds: 300),
              ));
        return;
      }

      if(isValid){
        _formKey.currentState!.save();
        widget.submfn(
         _useremail.trim(),
         _userpassword.trim(),
         _username.trim(),
         _userImageFile!,
         _isLogin,
         context
        );
        }


   }
  @override
  Widget build(BuildContext context) {
    return  Center(
       child: Card(
         margin: const EdgeInsets.all(20),
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(16),
             child: Form(
               key: _formKey,
               child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 if(!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: const ValueKey("email"),
                    validator:(value){
                               if(value!.isEmpty || !value.contains('@')){
                                 return "please enter valid email address.";
                               }
                               return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email address"
                    ),
                    onSaved: (value){
                         _useremail =value!;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: const ValueKey("username"),
                    validator: (value){
                      if(value!.isEmpty || value.length<4){
                        return "atleast 4 characters are required*";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Username"),
                     onSaved: (value){
                         _username =value!;
                    },
                  ),
                  TextFormField(
                       key: const ValueKey("password"),
                       validator: (value){
                      if(value!.isEmpty || value.length<7){
                        return "atleast 7 characters are required*";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                     onSaved: (value){
                        _userpassword =value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                    ),

                   if(widget.isLoading) const CircularProgressIndicator(), 
                  if(!widget.isLoading) 
                  ElevatedButton(
                    onPressed: _trySubmiti,
                    child: Text(_isLogin?"Login":"Sign up")),
                   if(!widget.isLoading)
                  TextButton( 
                    onPressed: (){
                      setState(() {
                        _isLogin =!_isLogin;
                      });
                    }, 
                    child:  Text(_isLogin?"create new Account":"already have account")),
                  
               ],
             )),
           ),
         ),
       ),
    );
  }
}