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
  bool _flipped = false;
  double _rotation = 0;

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

  void _flipImage(bool isVertical) {
    // Perform the flip operation (horizontal or vertical)
    setState(() {
      _flipped = !_flipped;
      if (isVertical) {
        // Flip vertically
        print('Flipping vertically');
      } else {
        // Flip horizontally
        print('Flipping horizontally');
      }
    });
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
          PopupMenuButton(
            icon: Icon(Icons.flip),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Flip Horizontally'),
                  value: false,
                ),
                PopupMenuItem(
                  child: Text('Flip Vertically'),
                  value: true,
                ),
              ];
            },
            onSelected: (bool isVertical) {
              _flipImage(isVertical);
            },
          ),
          IconButton(
            icon: Icon(Icons.crop),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(_flipped ? -1.0 : 1.0, _flipped ? -1.0 : 1.0),
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
