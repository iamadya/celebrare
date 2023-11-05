import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:html';
import 'dart:io';

import '../camera_operations/camera_operations.dart';

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
        _showSelectedImage =
            false; // Reset the flag when a new image is selected
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              // Customize the content inside the dialog as per your requirements
              // For instance, you can add your image, buttons, etc., as in the AlertDialog content
              // Ensure to adjust the styling and structure according to your needs
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selectedImage != null)
                    Image.file(
                      File(_selectedImage!.path),
                    ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildImageWithBorder(
                            'assets/images/user_image_frame_1.png'),
                        _buildImageWithBorder(
                            'assets/images/user_image_frame_2.png'),
                        _buildImageWithBorder(
                            'assets/images/user_image_frame_3.png'),
                        _buildImageWithBorder(
                            'assets/images/user_image_frame_4.png'),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _showSelectedImage = true;
                      });
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CameraOperation(imagePath: _selectedImage!.path),
                        ),
                      );
                    },
                    child: Text('Use this image'),
                    // Add button styling here
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildImageWithBorder(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            exit(0);
          },
        ),
        title: Text('Add Image / Icon',
            style: TextStyle(
                fontFamily: 'Bitter',
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.grey[600])),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text('Upload Image',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Bitter',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                _openGallery(context);
              },
              child: Text('Choose from Device',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    // height: 0.5
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF088178),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
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
    );
  }
}
