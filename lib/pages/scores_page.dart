import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:everdell_frontend/data/data.dart';
import 'package:everdell_frontend/model/score.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  final XFile imageFile;
  final ImageScoreModel imageScore;

  const ScorePage({
    super.key,
    required this.imageFile,
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
        centerTitle: true,
        title: Text(
          'Score Page',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              fit: BoxFit.cover,
              File(widget.imageFile.path),
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
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text('${widget.imageScore.score} Points',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cards',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 10),
                            ...widget.imageScore.cardNames!.map((cardName) {
                              return Text(cardName,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium);
                            }).toList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Others',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 10),
                            ...widget.imageScore.others!.entries.map((entry) {
                              return Text(
                                '${entry.key}: ${entry.value} occurences',
                                style: Theme.of(context).textTheme.bodyMedium,
                              );
                            }).toList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    Text('Score Details',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 10),
                    ...widget.imageScore.scoreDetails!.map((detail) {
                      return Text(detail,
                          style: Theme.of(context).textTheme.bodyMedium);
                    }).toList(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
