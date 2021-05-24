import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'favorite.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY,localização TEXT,bio TEXT,nickname TEXT,email TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await DBHelper.dataBase();
    db.insert(
      'favorites',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.dataBase();
    var res = await db.rawQuery("SELECT * FROM favorites");

    return res.toList();
  }

  static Future<void> delete(String nickname) async {
    final db = await DBHelper.dataBase();
    await db.rawDelete('DELETE FROM favorites WHERE nickname = ?', [nickname]);
  }
}
