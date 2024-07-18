import 'dart:convert';

class JogoGenero {
  final int game_id;
  final int genre_id;

  JogoGenero({required this.game_id, required this.genre_id});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "game_id": this.game_id,
      "genre_id": this.genre_id
    };
  }

  factory JogoGenero.fromMap(Map<String, dynamic> map) {
    return JogoGenero(
      game_id: map["id"],
      genre_id: map["name"],
    );
  }

  String toJson() => jsonEncode(toMap());
  factory JogoGenero.toJson(String fonte) => JogoGenero.fromMap(jsonDecode(fonte) as Map<String, dynamic>);
}