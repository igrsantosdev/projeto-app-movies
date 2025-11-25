import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/movie.dart';

class DBService {
  static final DBService instance = DBService._init();
  static Database? _database;

  DBService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final path = join(docsDir.path, 'movies.db');
    final db = await openDatabase(path, version: 1, onCreate: _createDB);
    // seed if empty
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM movies'));
    if (count == 0) {
      await _seed(db);
    }
    return db;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imageUrl TEXT NOT NULL,
        title TEXT NOT NULL,
        genre TEXT NOT NULL,
        ageRating TEXT NOT NULL,
        duration TEXT NOT NULL,
        rating REAL NOT NULL,
        description TEXT NOT NULL,
        year INTEGER NOT NULL
      )
    ''');
  }

  Future _seed(Database db) async {
    final data = await rootBundle.loadString('assets/seed.json');
    final list = (json.decode(data) as List).cast<Map<String, dynamic>>();
    for (var item in list) {
      await db.insert('movies', item);
    }
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await instance.database;
    final maps = await db.query('movies', orderBy: 'title');
    return maps.map((m) => Movie.fromMap(m)).toList();
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await instance.database;
    return await db.insert('movies', movie.toMap());
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await instance.database;
    return await db.update('movies', movie.toMap(), where: 'id = ?', whereArgs: [movie.id]);
  }

  Future<int> deleteMovie(int id) async {
    final db = await instance.database;
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }
}
