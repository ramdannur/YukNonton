import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/yuknonton.db';

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        type TEXT DEFAULT "movie" NOT NULL
      );
    ''');
  }

  Future<int> insertWatchlist(WatchlistTable watchlist) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, watchlist.toJson());
  }

  Future<int> removeWatchlist(WatchlistTable watchlist) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [watchlist.id],
    );
  }

  Future<Map<String, dynamic>?> getWatchlistById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistByType(
      [String type = "movie"]) async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlist, where: 'type = ?', whereArgs: [type]);

    return results;
  }
}
