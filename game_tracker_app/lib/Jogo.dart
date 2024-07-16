import 'dart:convert';

class Jogo {
  final int id;
  final int user_id;
  String? name;
  String? description;
  String? release_date;
  

  Jogo({required this.id, required this.user_id, this.name, this.description, this.release_date});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "id": this.id,
      "user_id": this.user_id,
      "name": this.name,
      "description": this.description,
      "release_date": this.release_date
    };
  }

  factory Jogo.fromMap(Map<String, dynamic> map) {
    return Jogo(
      id: map["id"],
      user_id: map["user_id"],
      name: map["name"],
      description: map["description"],
      release_date: map["release_date"]
    );
  }

  String toJson() => jsonEncode(toMap());
  factory Jogo.toJson(String fonte) => Jogo.fromMap(jsonDecode(fonte) as Map<String, dynamic>);
}