import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';

class ControladorJogos {
  DatabaseHelper con = DatabaseHelper();

  Future<int> cadastrarJogo(Jogo jogo) async {
    var db = await con.db;
    int res = await db.insert("game", jogo.toMap());
    return res;
  }

  Future<int> removerJogo(Jogo jogo) async {
    var db = await con.db;
    int res = await db.delete("jogo", where: "id = ?", whereArgs: [jogo.id]);
    return res;
  }

  Future<Jogo> getJogoID(int id) async{
    var db = await con.db;
    String sql = """
      SELECT * FROM game WHERE id = '${id}';
    """;
    var ret = await db.rawQuery(sql);
    return Jogo.fromMap(ret.first);
  }

  Future<List<Jogo>> getJogosUsuario(int user_id) async {
    List<Jogo> jogos = [];
    var db = await con.db;

    String sql = """
      SELECT * FROM game WHERE user_id = '${user_id}';
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++) {
      jogos.add(Jogo.fromMap(ret[i]));
    }

    return jogos;
  }

  Future<List<Jogo>> getTodosJogos() async {
    List<Jogo> jogos = [];
    var db = await con.db;

    String sql = """
      SELECT * FROM game;
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++) {
      jogos.add(Jogo.fromMap(ret[i]));
    }

    return jogos;
  }
}