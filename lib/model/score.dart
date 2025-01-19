class ImageScoreModel {
  List<String>? cardNames;
  int? score;
  List<String>? scoreDetails;
  Map<String, int>? others;

  ImageScoreModel({
    this.cardNames,
    this.score,
    this.scoreDetails,
    this.others,
  });

  factory ImageScoreModel.fromJson(Map<String, dynamic> json) {
    return ImageScoreModel(
      cardNames: json['card_names'] != null
          ? List<String>.from(json['card_names'])
          : null,
      score: json['score'] as int?,
      scoreDetails: json['score_details'] != null
          ? List<String>.from(json['score_details'])
          : null,
      others:
          json['resources'] != null && json['resources'] is Map<String, dynamic>
              ? Map<String, int>.from(json['resources'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_names': cardNames ?? [],
      'score': score ?? 0,
      'score_details': scoreDetails ?? [],
      'resources': others ?? {},
    };
  }
}
