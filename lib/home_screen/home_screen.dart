import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:html';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _selectedImage;
  bool _showSelectedImage = false; // Track whether to show the selected image

  Future<void> _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
        _showSelectedImage = false; // Reset the flag when a new image is selected
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Uploaded Image',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedImage != null)
                  Image.file(
                    File(_selectedImage!.path),
                  ),
                SizedBox(height: 10),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _showSelectedImage = true; // Set the flag to true on button press
                    });
                    Navigator.of(context).pop(); // Close the Alert Dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraOperations(imagePath: image.path),
                      ),
                    );
                  },
                  child: Text(
                    'Use this image',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.of(context).pop(); // Closing the dialog
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //... Your existing app bar code remains unchanged
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text('Upload Image', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  _openGallery(context);
                },
                child: Text('Choose from Device', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_selectedImage != null && _showSelectedImage)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Image.file(
                    File(_selectedImage!.path),
                    height: 400,
                    width: 400,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
