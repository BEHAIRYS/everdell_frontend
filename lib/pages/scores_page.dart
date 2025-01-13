import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:everdell_frontend/data/data.dart';
import 'package:everdell_frontend/model/score.dart';
import 'package:flutter/material.dart';

//REPLACE MOCKED DATA WITH ACTUAL IMAGE
class ScorePage extends StatefulWidget {
  // final XFile imageFile;
  final ImageScoreModel imageScore;

  const ScorePage({
    super.key,
    // required this.imageFile,
    required this.imageScore,
  });

  @override
  State<StatefulWidget> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  ImageScoreModel mockData = ImageScoreModel.fromJson(data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Page'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/everdell-bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '${mockData.score} Points',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cards Detected:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...mockData.cardNames.map((cardName) {
                    return Text(
                      cardName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  Text(
                    'Score Details:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...mockData.scoreDetails.map((detail) {
                    return Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
