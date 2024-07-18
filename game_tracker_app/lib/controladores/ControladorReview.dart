import 'package:game_tracker_app/Review.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';

class ControladorReview {
  DatabaseHelper con = DatabaseHelper();

  Future<int> adicionarReview(Review review) async {
    var db = await con.db;
    int res = await db.insert("review", review.toMap());
    return res;
  }

  Future<int> removerReview(Review review) async {
    var db = await con.db;
    int res = await db.delete("review", where: "id = ?", whereArgs: [review.id]);
    return res;
  }

  Future<Review> getReviewID(int id) async {
    var db = await con.db;
    String sql = """
      SELECT * FROM review WHERE id = '${id}';
    """;
    var ret = await db.rawQuery(sql);
    return Review.fromMap(ret.first);
  }

  Future<List<Review>> getReviewsJogo(int game_id) async {
    var db = await con.db;
    List<Review> reviews = [];
    
    String sql = """
      SELECT * FROM review WHERE game_id = '${game_id}';
    """;

    var ret = await db.rawQuery(sql);
    for (int i = 0; i < ret.length; i++) {
      reviews.add(Review.fromMap(ret[i]));
    }

    return reviews;
  }

  Future<List<Review>> getTodasReviews() async {
    var db = await con.db;
    List<Review> reviews = [];

    String sql = """
      SELECT * FROM review;
    """;

    var ret = await db.rawQuery(sql);

    for (int i = 0; i < ret.length; i++)
      reviews.add(Review.fromMap(ret[i]));

    return reviews;
  }
  /*
  Future<DateTime> getDataReview(Review review) async {
    var db = await con.db;
    
    String sql = """
      SELECT date FROM review WHERE id = ${review.id};
    """;

    String res = db.rawQuery(sql);
    return DateTime.parse(res + " 00:00:00");
  }*/

  
/*
  //Adicionando para pegar o valor das medias
  Future<double> getMediaReviews(int game_id) async{
    var db = await con.db;
    double valorMedia = 0.0;
    
    
    String sql = """
      SELECT AVG(score) FROM review WHERE game_id = '${game_id}';
    """;
    
    var ret = await db.rawQuery(sql);
    valorMedia = 
    
    return valorMedia;
  }

*/

}