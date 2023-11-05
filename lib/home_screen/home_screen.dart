import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:html';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? _selectedImage;
  bool _showSelectedImage = false;

  Future<void> _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      // If image is selected, show it in a dialog or popup container
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
                if (_showSelectedImage) // Check if the flag is true to show the image
                  Image.file(
                    File(image.path),
                  ),
                Image.file(
                  File(image.path),
                ),
                SizedBox(height: 10),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _showSelectedImage = true;  //if the condition is true show image otherwise don't
                    });
                    Navigator.of(context).pop(); // Close the Alert Dialog
                  },
                  child: Text('Use this image',
                      style: TextStyle(
                        fontSize: 15,
                        // letterSpacing: 1,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius to change the shape
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
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Add Image / Icon',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        elevation: 20,
      ),
      body: Container(
        // color: Colors.redAccent,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.black, // Choose the color of the border
        //     width: 2.0, // Set the width of the border
        //   ),
        // ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text('Upload Image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  )),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  // print('button  clicked');
                  _openGallery(context);
                },
                child: Text('Choose from Device',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius to change the shape
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_selectedImage != null && _showSelectedImage)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
