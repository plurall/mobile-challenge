import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBUtil {
  static const dbName = 'favorites.db';
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print(path.join(dbPath, dbName));
    return sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites (id INT PRIMARY KEY, login TEXT, name TEXT, avatar TEXT, location TEXT, email TEXT, bio TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    print('data $data');
    final db = await DBUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table, int id) async {
    final db = await DBUtil.database();
    await db.delete(
      table,
      where: 'id == ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBUtil.database();
    return db.query(table);
  }
}
