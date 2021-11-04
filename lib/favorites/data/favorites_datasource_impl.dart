import 'package:mobile_challenge/favorites/data/favorites_datasource.dart';
import 'package:mobile_challenge/favorites/utils/database_connection.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDatasourceImpl implements FavoritesDatasource {
  @override
  Future<List<User>> findAll() async {
    final Database db = await DatabaseConnection.connectDB();

    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        login: maps[i]['login'],
        avatarUrl: maps[i]['avatarUrl'],
        location: maps[i]['location'],
        email: maps[i]['email'],
        bio: maps[i]['bio'],
      );
    });
  }

  @override
  Future<void> save(User user) async {
    final Database db = await DatabaseConnection.connectDB();

    await db.insert(
      'favorites',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> delete(User user) async {
    final Database db = await DatabaseConnection.connectDB();

    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
