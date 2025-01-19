// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:everdell_frontend/config/app_config.dart';
import 'package:everdell_frontend/pages/scores_page.dart';
import 'package:everdell_frontend/service/score_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CameraWidget extends StatefulWidget {
  CameraWidget({required this.controller, this.imageFile, super.key});
  XFile? imageFile;
  final CameraController controller;

  @override
  State<StatefulWidget> createState() => _CameraState();
}

class _CameraState extends State<CameraWidget> {
  late ScoreService scoreService;
  @override
  void initState() {
    super.initState();
    scoreService = ScoreService(baseUrl: BASE_URL);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: CameraPreview(widget.controller)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _takePicture();
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              child: const Icon(Icons.camera),
            ),
          ),
        ),
      ],
    );
  }

  void _takePicture() async {
    try {
      final XFile picture = await widget.controller.takePicture();
/*
      final ByteData imageData =
          await rootBundle.load('assets/images/cityTest.jpg');
      final Uint8List bytes = imageData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/cityTest.jpg');
      await tempFile.writeAsBytes(bytes);

      // Use the temporary file as an XFile
      final XFile mockedImage = XFile(tempFile.path);
*/
      if (!mounted) return;

      setState(() {
        widget.imageFile = picture;
      });
      final imageScore = await scoreService.fetchScore(File(picture.path));
      //final mockedScore = await scoreService.fetchScore(File(mockedImage.path));

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(
            imageFile: widget.imageFile!,
            imageScore: imageScore,
          ),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }
}
