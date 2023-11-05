import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img; // Import image package
import 'dart:io';

class CameraOperations extends StatefulWidget {
  final String imagePath;

  const CameraOperations({required this.imagePath});

  @override
  _CameraOperationsState createState() => _CameraOperationsState();
}

class _CameraOperationsState extends State<CameraOperations> {
  late File _imageFile;
  late img.Image? _image;

  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.imagePath);
    _loadImage();
  }

  Future<void> _loadImage() async {
    final Uint8List bytes = await _imageFile.readAsBytes();
    final Uint8List imageUint8List = Uint8List.fromList(bytes);

    _image = img.decodeImage(imageUint8List);
    if (_image == null) {
      throw Exception("Unable to load image");
    }
    setState(() {});
  }

  void _rotateImage() {
    if (_image != null) {
      final img.Image newImage = img.copyRotate(_image!, 90); // Rotate 90 degrees
      setState(() {
        _image = newImage;
      });
    }
  }

  void _flipImage() {
    if (_image != null) {
      final img.Image newImage = img.flipHorizontal(_image!); // Flip horizontally
      setState(() {
        _image = newImage;
      });
    }
  }

  void _cropImage() {
    if (_image != null) {
      final img.Image newImage = img.copyCrop(_image!, 100, 100, 300, 300); // Crop from (100,100) to (300,300)
      setState(() {
        _image = newImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.rotate_right),
            onPressed: _rotateImage,
          ),
          IconButton(
            icon: Icon(Icons.flip),
            onPressed: _flipImage,
          ),
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: _cropImage,
          ),
        ],
      ),
      body: _image != null
          ? Center(
        child: Image.memory(Uint8List.fromList(img.encodeJpg(_image!))),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
