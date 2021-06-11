import 'dart:async';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelp {
  static Future<Database> getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, login TEXT, bio TEXT, location TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertItem(UserModel model) async {
    final db = await DatabaseHelp.getDb();
    await db.insert(
      'favorites',
      UserModel.toMap(model),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserModel>> getItems() async {
    final db = await DatabaseHelp.getDb();
    final List<Map<String, dynamic>> list = await db.query('favorites');
    return list.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<void> deleteItem(int id) async {
    final db = await DatabaseHelp.getDb();
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
