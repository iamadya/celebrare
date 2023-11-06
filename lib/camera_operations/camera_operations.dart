import 'dart:io';
import 'package:flutter/material.dart';

class CameraOperation extends StatefulWidget {
  final String imagePath;

  const CameraOperation({Key? key, required this.imagePath});

  @override
  _CameraOperationState createState() => _CameraOperationState();
}

class _CameraOperationState extends State<CameraOperation> {
  File? _imageFile;
  double _rotation = 0;
  bool _flippedHorizontally = false;
  bool _flippedVertically = false;
  double _cropBoxSize = 200; // Initial size of the crop box

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

  void _flipHorizontally() {
    setState(() {
      _flippedHorizontally = !_flippedHorizontally;
    });
  }

  void _flipVertically() {
    setState(() {
      _flippedVertically = !_flippedVertically;
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
          IconButton(
            icon: Icon(Icons.flip),
            iconSize: 30,
            onPressed: _flipHorizontally,
          ),
          IconButton(
            icon: Icon(Icons.crop_rotate),
            iconSize: 30,
            onPressed: _flipVertically,
          ),
        ],
      ),
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(_rotation * (3.1415926535897932 / 180))
            ..scale(_flippedHorizontally ? -1.0 : 1.0, _flippedVertically ? -1.0 : 1.0),
          child: Stack(
            children: [
              Image.file(
                _imageFile!,
                height: 400,
                width: 400,
              ),
              Positioned(
                top: (400 - _cropBoxSize) / 2,
                left: (400 - _cropBoxSize) / 2,
                child: CropBox(
                  size: _cropBoxSize,
                  onSizeChanged: (newSize) {
                    setState(() {
                      _cropBoxSize = newSize;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CropBox extends StatelessWidget {
  final double size;
  final ValueChanged<double> onSizeChanged;

  const CropBox({
    required this.size,
    required this.onSizeChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        onSizeChanged(size);
      },
      onScaleUpdate: (details) {
        double newSize = size * details.scale;
        onSizeChanged(newSize.clamp(100.0, 400.0)); // Limit the minimum and maximum size
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
      ),
    );
  }
}
