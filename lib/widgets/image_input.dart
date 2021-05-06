import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function getImage;
  ImageInput(this.getImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final _pickedImage = await _picker.getImage(source: ImageSource.camera);

    if (_pickedImage == null) {
      return;
    }

    setState(() {
      _storedImage = File(_pickedImage.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_pickedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');

    widget.getImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.landscape,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
          ),
        ),
      ],
    );
  }
}

//  Future<void> _takePicture() async {
//     final _picker = ImagePicker();
//     final _pickedImage = await _picker.getImage(source: ImageSource.camera);

//     if (_pickedImage == null) {
//       return;
//     }

//     setState(() {
//       _storedImage = File(_pickedImage.path);
//     });

//     final appDir = await syspath.getApplicationDocumentsDirectory();
//     final fileName = path.basename(_pickedImage.path);
//     final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
//   }
