// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Camera & Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: duplicate_ignore
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => CameraGalleryScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class CameraGalleryScreen extends StatefulWidget {
  const CameraGalleryScreen({super.key});

  @override
  _CameraGalleryScreenState createState() => _CameraGalleryScreenState();
}

class _CameraGalleryScreenState extends State<CameraGalleryScreen> {
   File? _image;

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      
      });
    
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
   if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodScan+:Local Food Detector',
         style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: unnecessary_null_comparison
            _image != null
                ? Image.file(
                    _image!,
                    width: 300,
                    height: 300,
                  )
                : const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: const Text('Upload A Ghanaian Food'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Dish from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
