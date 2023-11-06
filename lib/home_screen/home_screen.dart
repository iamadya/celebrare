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
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon:
                          Icon(Icons.cancel, size: 30, color: Colors.grey[600]),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Text('Uploaded Image',
                      style: TextStyle(
                          fontFamily: 'Bitter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 2)),
                  if (_selectedImage != null)
                    Image.file(
                      File(_selectedImage!.path),
                    ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                  5), // Optional: Set border radius for rounded corners
                            ),
                            child: Text(
                              'Original',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )),
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
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: FilledButton(
                      onPressed: () {
                        // _openGallery(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraOperation(
                                imagePath: _selectedImage!.path),
                          ),
                        );
                      },
                      child: Text('Use this image',
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
