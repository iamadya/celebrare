import 'dart:io';
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
  bool _flippedHorizontally = false;
  bool _flippedVertically = false;

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
      _flippedHorizontally = !_flippedHorizontally;
      _flippedVertically = !_flippedVertically;
    });
  }

  Future<String> _getFlippedImagePath() async {
    // Replace this with your logic to flip the image and save it to a new file
    // For example:
    // Perform flipping operation on _imageFile
    // File flippedFile = performFlippingOperation(_imageFile);
    // String flippedImagePath = flippedFile.path;

    String flippedImagePath = _imageFile!.path; // Replace this line with the actual flipping logic

    return flippedImagePath;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
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
            iconSize: 30,
            onPressed: _rotateImage,
          ),
          IconButton(
            icon: Icon(Icons.flip),
            iconSize: 30,
            onPressed: _flipImage,
          ),
          IconButton(
            icon: Icon(Icons.crop),
            iconSize: 30,
            onPressed: () async {
              String flippedImagePath = await _getFlippedImagePath();
              Navigator.pop(context, flippedImagePath);
            },
          ),
        ],
      ),
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(_rotation * 0.0174533)
            ..scale(_flippedHorizontally ? -1.0 : 1.0, _flippedVertically ? -1.0 : 1.0),
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
