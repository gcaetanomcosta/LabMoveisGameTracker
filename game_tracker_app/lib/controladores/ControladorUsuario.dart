import 'package:game_tracker_app/helper/DatabaseHelper.dart';
import 'package:game_tracker_app/Usuario.dart';

class ControladorLogin {
  DatabaseHelper con = DatabaseHelper();

  Future<int> cadastrarUsuario(Usuario usuario) async {
    var db = await con.db;
    int res = await db.insert("user", usuario.toMap());
    return res;
  }

  Future<int> removerUsuario(Usuario usuario) async {
    var db = await con.db;
    int res = await db.delete("user", where: "id = ?", whereArgs: [usuario.id]);
    return res;
  }

  Future<Usuario> getLogin(String apelido, String senha) async {
    var db = await con.db;

    String sql = """
      SELECT * FROM user WHERE name = '${apelido}' AND password = '${senha}'
    """;

    var res = await db.rawQuery(sql);

    if (res.length > 0) {
      return Usuario.fromMap(res.first);
    }

    return Usuario(id: -1, name: "", email: "", password: "");
  }

  Future<List<Usuario>> getTodosUsuarios() async {
    var db = await con.db;

    var res = await db.query("user");

    List<Usuario> lista = res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];
    return lista; 
  }

  Future<int> getApelidoEscolhido(String apelido) async {
    var db = await con.db;

    String sql = """
      SELECT * FROM user WHERE name = '${apelido}'
    """;

    var res = await db.rawQuery(sql);

    if (res.length > 0)
      return 1;
    else return 0;
  }
}