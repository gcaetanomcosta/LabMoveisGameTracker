import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Genero.dart';
import 'package:game_tracker_app/JogoGenero.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';

class ControladorJogoGenero {
  DatabaseHelper con = DatabaseHelper();

  Future<int> associarJogoGenero(Genero genero, Jogo jogo) async {
    var db = await con.db;

    Map<String, dynamic> gen = genero.toMap();
    Map<String, dynamic> game = jogo.toMap();

    Map<String, dynamic> game_genre = {"game_id": game, "genre_id": gen};

    int res = await db.insert("game_genre", game_genre);
    return res;
  }

  Future<List<Genero>> listaGenerosJogo(Jogo jogo) async {
    var db = await con.db;
    List<Genero> generos = [];

    String sql = """
      SELECT genre.id, genre.name FROM game_genre
      WHERE game_id = ${jogo.id}
      LEFT JOIN genre ON game_genre.genre_id = genre.id;
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++)
      generos.add(Genero.fromMap(ret[i]));

    return generos;
  }

  Future<List<Jogo>> listaJogosGenero(Genero genero) async {
    var db = await con.db;
    List<Jogo> jogos = [];

    String sql = """
      SELECT 
        game.id, 
        game.user_id, 
        game.name, 
        game.release_date, 
        game.description
      FROM game_genre
      WHERE genre_id = ${genero.id}
      LEFT JOIN game ON game_genre.game_id = game.id;
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++)
      jogos.add(Jogo.fromMap(ret[i]));

    return jogos;
  }

  Future<int> desassociaJogoGenero(Jogo jogo, Genero genero) async {
    var db = await con.db;

    int res = await db.delete("game_genre", where: "game_id = ? AND genre_id = ?", whereArgs: [jogo.id, genero.id]);
    return res;
  }

  Future<List<JogoGenero>> getTodasAssociacoes() async {
    List<JogoGenero> associacoes = [];
    var db = await con.db;

    String sql = """
      SELECT * FROM game_genre;
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++) {
      associacoes.add(JogoGenero.fromMap(ret[i]));
    }

    return associacoes;
  }
}