import 'dart:convert';
import 'dart:io';
import 'package:everdell_frontend/model/score.dart';
import 'package:http/http.dart' as http;

class ScoreService {
  final String baseUrl;

  ScoreService({required this.baseUrl});

  Future<ImageScoreModel> fetchScore(File imageFile) async {
    try {
      final url = Uri.parse('$baseUrl/api/score');
      final request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonMap = jsonDecode(responseBody);
        return ImageScoreModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch score: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> editScore(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/api/data');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post data');
    }
  }
}
