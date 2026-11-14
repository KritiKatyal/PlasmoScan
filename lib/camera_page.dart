import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'result.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String img =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';

  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool _isFileSelected = false;
  bool _isProcessing = false;

  // Pick Image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isFileSelected = true;
      });
    }
  }

  void _startProcessing() async {
    if (_image == null) return;

    setState(() {
      _isProcessing = true; // Start ripple animation
    });

    // Simulating video play duration (2.5 seconds)
    await Future.delayed(Duration(seconds: 3));

    var result = await _sendImageToServer(_image!);

    List<dynamic> predictions = result["predictions"] ?? [];
    // String? imageUrl = result["image_url"];

    setState(() {
      _isProcessing = false; // Stop animation
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          imageFile: XFile(_image!.path),
          predictions: predictions,
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _sendImageToServer(File imageFile) async {
    final String apiUrl = "https://kriti-katyal-malaria.hf.space/predict";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
      request.headers['Authorization'] =
          "Bearer hf_add_your_token_here";
      //create your api key from huggingfaces //commmented for security purpose
      request.files
          .add(await http.MultipartFile.fromPath("file", imageFile.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return {
          "predictions": jsonResponse["predictions"] ?? [],
          "image_url": jsonResponse["image_url"]
        };
      } else {
        return {"predictions": [], "image_url": null};
      }
    } catch (e) {
      return {"predictions": [], "image_url": null};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Scan image',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),

            // Show selected image if available, otherwise show default network image
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(_image!,
                        width: 140, height: 140, fit: BoxFit.cover),
                  )
                : Image.asset('assets/malaria_illustration.png', width: 200),

            // : Image.network(img, width: 200),

            const SizedBox(height: 30),

            Text(
              'Upload or Capture an Image',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800),
            ),
            const SizedBox(height: 8),
            Text('File should be jpg, png',
                style: TextStyle(fontSize: 15, color: Colors.grey.shade500)),
            const SizedBox(height: 15),

            // Upload from Gallery
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.blue.shade400,
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Iconsax.folder_open, color: Colors.blue, size: 40),
                        SizedBox(height: 15),
                        Text('Select from Gallery',
                            style: TextStyle(fontSize: 15, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Capture from Camera
            GestureDetector(
              onTap: () => _pickImage(ImageSource.camera),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.blue.shade400,
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Iconsax.camera, color: Colors.blue, size: 40),
                        SizedBox(height: 15),
                        Text('Capture with Camera',
                            style: TextStyle(fontSize: 15, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Upload & Process Button
            if (_image != null && !_isProcessing)
              GestureDetector(
                onTap: _startProcessing,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    color: Colors.green.shade400,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Upload & Process',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Processing Animation
            if (_isProcessing)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: LoadingAnimationWidget.progressiveDots(
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 30), // Adjust padding as needed
                    child: Text(
                      "Processing...",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
