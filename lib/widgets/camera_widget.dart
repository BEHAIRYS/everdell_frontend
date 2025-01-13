// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:everdell_frontend/config/app_config.dart';
import 'package:everdell_frontend/data/data.dart';
import 'package:everdell_frontend/model/score.dart';
import 'package:everdell_frontend/pages/scores_page.dart';
import 'package:everdell_frontend/service/score_service.dart';
import 'package:flutter/material.dart';

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
            margin: const EdgeInsets.all(10),
            child: CameraPreview(widget.controller)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                //_takePicture();
                final mockData = ImageScoreModel.fromJson(data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScorePage(
                      // imageFile: widget.imageFile!,
                      imageScore: mockData,
                    ),
                  ),
                );
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

      if (!mounted) return;

      setState(() {
        widget.imageFile = picture;
      });
      final mockData = ImageScoreModel.fromJson(data);
      final imageScore = await scoreService.fetchScore(File(picture.path));

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(
            imageScore: mockData,
          ),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }
}
