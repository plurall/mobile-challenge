import 'package:mobile_challenge/data/datasources/database_interface.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class Database implements DatabaseInterface {
  final String _dbName = 'favorites.db';

  @override
  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites (id INT PRIMARY KEY, login TEXT, name TEXT, avatar TEXT, location TEXT, email TEXT, bio TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> delete(String table, int id) async {
    final db = await database();
    await db.delete(
      table,
      where: 'id == ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }
}
