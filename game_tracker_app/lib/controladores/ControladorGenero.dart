import 'package:game_tracker_app/Genero.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';

class ControladorGenero {
  DatabaseHelper con = DatabaseHelper();

  Future<int> cadastrarGenero(Genero genero) async {
    var db = await con.db;
    int res = await db.insert("genre", genero.toMap());
    return res;
  }

  Future<int> removerGenero(Genero genero) async {
    var db = await con.db;
    int res = await db.delete("genre", where: "id = ?", whereArgs: [genero.id]);
    return res;
  }

  Future<Genero> getGeneroID(int id) async{
    var db = await con.db;
    String sql = """
      SELECT * FROM genre WHERE id = '${id}';
    """;
    var ret = await db.rawQuery(sql);
    return Genero.fromMap(ret.first);
  }

  Future<List<Genero>> getGenerosUsuario(int user_id) async {
    List<Genero> generos = [];
    var db = await con.db;

    String sql = """
      SELECT * FROM genre WHERE user_id = '${user_id}';
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++) {
      generos.add(Genero.fromMap(ret[i]));
    }

    return generos;
  }

  Future<List<Genero>> getTodosGeneros() async {
    List<Genero> generos = [];
    var db = await con.db;

    String sql = """
      SELECT * FROM genre;
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++) {
      generos.add(Genero.fromMap(ret[i]));
    }

    return generos;
  }
}