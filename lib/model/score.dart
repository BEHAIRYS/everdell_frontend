class ImageScoreModel {
  final List<String> cardNames;
  final int score;
  final List<String> scoreDetails;

  ImageScoreModel({
    required this.cardNames,
    required this.score,
    required this.scoreDetails,
  });

  factory ImageScoreModel.fromJson(Map<String, dynamic> json) {
    return ImageScoreModel(
      cardNames: List<String>.from(json['card_names']),
      score: json['score'] as int,
      scoreDetails: List<String>.from(json['score_details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_names': cardNames,
      'score': score,
      'score_details': scoreDetails,
    };
  }
}
