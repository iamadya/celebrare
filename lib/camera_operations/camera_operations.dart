import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CameraOperation extends StatefulWidget {
  final String imagePath;

  const CameraOperation({Key? key, required this.imagePath}) : super(key: key);

  @override
  _CameraOperationState createState() => _CameraOperationState();
}

class _CameraOperationState extends State<CameraOperation> {
  File? _imageFile;
  double _rotation = 0;
  bool _flipped = false;

  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.imagePath);
  }

  void _rotateImage() {
    setState(() {
      _rotation += 90;
    });
  }

  void _flipImage() {
    setState(() {
      _flipped = !_flipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
            onPressed: _rotateImage,
          ),
        ],
      ),
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(_rotation * 0.0174533 * (_flipped ? -1 : 1)),
          child: Image.file(
            _imageFile!,
            height: 400,
            width: 400,
          ),
        ),
      ),
    );
  }
}
