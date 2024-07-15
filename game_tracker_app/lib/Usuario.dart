import 'dart:convert';

class Usuario {
  final int id;
  final String name;
  String email;
  final String password;

  Usuario({required this.id, required this.name, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "password": this.password
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map["id"] ??= map["id"],
      name: map["name"] as String,
      email: map["email"] as String,
      password: map["password"] as String
    );
  }

  String toJson() => jsonEncode(toMap());
  factory Usuario.fromJson(String source) => Usuario.fromMap(jsonDecode(source) as Map<String, dynamic>);
}