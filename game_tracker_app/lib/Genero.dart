import 'dart:convert';

class Genero {
  final int id;
  String? name;

  Genero({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "id": this.id,
      "name": this.name
    };
  }

  factory Genero.fromMap(Map<String, dynamic> map) {
    return Genero(
      id: map["id"],
      name: map["name"],
    );
  }

  String toJson() => jsonEncode(toMap());
  factory Genero.toJson(String fonte) => Genero.fromMap(jsonDecode(fonte) as Map<String, dynamic>);
}