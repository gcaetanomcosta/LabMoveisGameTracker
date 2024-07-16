import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instancia = DatabaseHelper.internal();
  static Database? _db;

  factory DatabaseHelper() => _instancia;

  DatabaseHelper.internal();

  Future<Database> get db async {
    return _db ??= await initDb();
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "data.db");

    Database db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Criação da tabela 'user'
        await db.execute("""
          CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR NOT NULL,
            email VARCHAR NOT NULL,
            password VARCHAR NOT NULL
          );
        """);

        // Criação da tabela 'genre'
        await db.execute("""
          CREATE TABLE genre(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR NOT NULL
          );
        """);

        // Criação da tabela 'game'
        await db.execute("""
          CREATE TABLE game(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            name VARCHAR NOT NULL UNIQUE,
            description TEXT NOT NULL,
            release_date VARCHAR NOT NULL,   
            FOREIGN KEY(user_id) REFERENCES user(id)
          );
        """);

        // Criação da tabela 'game_genre'
        await db.execute("""
          CREATE TABLE game_genre(
            game_id INTEGER NOT NULL,
            genre_id INTEGER NOT NULL,
            FOREIGN KEY(game_id) REFERENCES game(id),
            FOREIGN KEY(genre_id) REFERENCES genre(id)
          );
        """);

        // Criação da tabela 'review'
        await db.execute("""
          CREATE TABLE review(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            game_id INTEGER NOT NULL,
            score REAL NOT NULL,
            description TEXT NOT NULL,
            date VARCHAR NOT NULL,
            FOREIGN KEY(user_id) REFERENCES user(id),
            FOREIGN KEY(game_id) REFERENCES game(id)
          );
        """);
      }
    );

    return db;
  }

}