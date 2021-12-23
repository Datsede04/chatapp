import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  
   final picker = ImagePicker();
   XFile? _pickedImage;
   bool _ispicked = false;

  @override
  Widget build(BuildContext context) {
  void _pickImage() async {
   
    // ignore: deprecated_member_use
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
      );

    setState(() {
      _pickedImage = image;
      _ispicked = true;
    });

    widget.imagePickFn(File(_pickedImage!.path));
  }
    return Column(
      children: <Widget>[
         CircleAvatar(
          radius: 40,
          backgroundColor: Colors.pink,
          child: CircleAvatar(
              radius: 40,
              backgroundImage:_ispicked ? Image.file(File(_pickedImage!.path),fit:BoxFit.cover,).image : Image.network("https://cdn4.vectorstock.com/i/1000x1000/06/18/male-avatar-profile-picture-vector-10210618.jpg", fit: BoxFit.cover,).image,
              backgroundColor: Colors.transparent,
             ),
            ),
        TextButton.icon(
          style:TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
          onPressed: _pickImage, 
          icon: const Icon(Icons.image), 
          label: const Text('Add image')),
       ],
    );
  }
}

