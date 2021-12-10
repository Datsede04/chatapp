import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm();

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
   final _formKey = GlobalKey<FormState>();
   var _isLogin  = true;
   String _username ='';
   String _useremail='';
   String _userpassword=''; 

   void _trySubmiti(){
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus(); //to close the keybore 
      
      if(isValid){
        _formKey.currentState!.save();
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
                    decoration: const InputDecoration(labelText: "Passwor"),
                    obscureText: true,
                     onSaved: (value){
                        _userpassword =value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                    ),
                  ElevatedButton(
                    onPressed: _trySubmiti,
                    child: Text(_isLogin?"Login":"Sign up")),
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