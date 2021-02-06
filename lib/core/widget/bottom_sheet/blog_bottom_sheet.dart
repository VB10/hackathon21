import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

import '../../../features/blog/model/blog_model.dart';

class BlogBottomSheet extends StatefulWidget {
  final void Function(PostModel model, File image) onCompleted;

  const BlogBottomSheet({Key key, this.onCompleted}) : super(key: key);
  @override
  _BlogBottomSheetState createState() => _BlogBottomSheetState();
}

class _BlogBottomSheetState extends State<BlogBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: SafeArea(
        child: Column(
          children: [
            Divider(indent: context.dynamicWidth(0.45), endIndent: context.dynamicWidth(0.45), thickness: 5),
            Text('ss'),
            Expanded(child: _image == null ? Placeholder() : Image.file(_image)),
            TextField(controller: titleController),
            TextField(controller: descriptionController),
            RaisedButton.icon(
                onPressed: () {
                  _getImage();
                },
                icon: Icon(Icons.add_a_photo),
                label: Text('add Photo')),
            OutlineButton(
              onPressed: () {
                widget.onCompleted(PostModel(title: titleController.text, description: descriptionController.text), _image);
              },
              child: Center(child: Text('Complete')),
            )
          ],
        ),
      ),
    );
  }
}
