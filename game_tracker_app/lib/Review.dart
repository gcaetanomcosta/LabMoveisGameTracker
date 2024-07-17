import 'dart:convert';

class Review {
  final int id;
  final int user_id;
  final int game_id;
  double? score;
  String? description;
  final String date;

  Review(
      {required this.id,
      required this.user_id,
      required this.game_id,
      required this.score,
      required this.description,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "user_id": this.user_id,
      "game_id": this.game_id,
      "score": this.score,
      "description": this.description,
      "date": this.date
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
        id: map["id"],
        user_id: map["user_id"],
        game_id: map["game_id"],
        score: map["score"],
        description: map["description"],
        date: map["date"]);
  }

  String toJson() => jsonEncode(toMap());
  factory Review.fromJson(String fonte) => Review.fromMap(jsonDecode(fonte) as Map<String, dynamic>);
}
