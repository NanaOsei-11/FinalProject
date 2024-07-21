// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, avoid_print, unused_field, library_private_types_in_public_api, sized_box_for_whitespace, sort_child_properties_last

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'G F R',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> history = [];
  List<String> favorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.darken,
            ),
            child: Image.asset(
              'assets/Background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Welcome to Ghanaian Food Recognition',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CameraGalleryScreen(
                                history: history,
                                favorites: favorites,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Get Started'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (history.isNotEmpty)
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'History',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                    itemCount: history.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => ImageScreen(
                                                imagePath: history[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color:
                                                Colors.white.withOpacity(0.2),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.file(
                                                    File(history[index]),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Uploaded Image ${index + 1}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            history.clear();
          });
        },
        child: const Icon(Icons.cleaning_services_outlined),
        backgroundColor: Colors.white10,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/Background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.99),
                BlendMode.darken,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.history),
                color: Colors.white,
                onPressed: () {
                  // Show history
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('History'),
                      content: Container(
                        width: double.maxFinite,
                        height: 300,
                        child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(File(history[index])),
                              ),
                              title: Text('Uploaded Image ${index + 1}'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ImageScreen(
                                      imagePath: history[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.white,
                onPressed: () {
                  // Show favorites
                },
              ),
              IconButton(
                icon: const Icon(Icons.public),
                color: Colors.white,
                onPressed: () async {
                  const url =
                      'https://insanelygoodrecipes.com/ghana-foods/'; // Replace with your desired URL
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraGalleryScreen extends StatefulWidget {
  final List<String> history;
  final List<String> favorites;

  const CameraGalleryScreen({required this.history, required this.favorites});

  @override
  _CameraGalleryScreenState createState() => _CameraGalleryScreenState();
}

class _CameraGalleryScreenState extends State<CameraGalleryScreen> {
  File? _image;
  String? _imageName;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/final_best_float32.tflite",
        labels: "assets/labels.txt",
      );
      print("Model loaded: $res");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageName = pickedFile.path;
        widget.history.add(pickedFile.path);
      });

      _runModelOnImage(_image!);
    }
  }

  Future<void> _runModelOnImage(File image) async {
    if (_image == null) {
      print("No image selected");
      return;
    }

    // Read the image
    final imageBytes = await image.readAsBytes();
    final decodedImage = img.decodeImage(imageBytes);

    if (decodedImage == null) {
      print("Error decoding image");
      return;
    }

    // Resize the image to 224x224
    final resizedImage = img.copyResize(decodedImage, width: 224, height: 224);

    // Create a buffer to hold the normalized pixel values
    final input = Float32List(224 * 224 * 3); // Adjusted for RGB channels

    int pixelIndex = 0;
    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        // Get the pixel value
        int pixel = resizedImage.getPixel(x, y);

        // Extract RGB components
        int red = img.getRed(pixel);
        int green = img.getGreen(pixel);
        int blue = img.getBlue(pixel);

        // Normalize the RGB values to [0, 1]
        input[pixelIndex++] = red / 255.0;
        input[pixelIndex++] = green / 255.0;
        input[pixelIndex++] = blue / 255.0;
      }
    }

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
    );

    setState(() {
      // Update UI with the result
      print("Model output: $recognitions");
    });
  }

  void _clearImage() {
    setState(() {
      _image = null;
      _imageName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.overlay,
            ),
            child: Image.asset(
              'assets/Background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(''),
              ),
              Expanded(
                child: Center(
                  child: _image == null
                      ? const Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        )
                      : Stack(
                          children: [
                            Image.file(_image!),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: _clearImage,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "camera",
                      onPressed: () => _getImage(ImageSource.camera),
                      tooltip: 'Pick Image from Camera',
                      child: const Icon(Icons.add_a_photo),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.redAccent[700],
                    ),
                    FloatingActionButton(
                      heroTag: "gallery",
                      onPressed: () => _getImage(ImageSource.gallery),
                      tooltip: 'Pick Image from Gallery',
                      child: const Icon(Icons.photo_library),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellowAccent,
                    ),
                    FloatingActionButton(
                      heroTag: "recipes",
                      onPressed: () async {
                        const url =
                            'https://insanelygoodrecipes.com/ghana-foods/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      tooltip: 'View Recipes Online',
                      child: const Icon(Icons.public),
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 5, 71, 41),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Dishes'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
