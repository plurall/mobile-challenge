import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static Future<Database> connectDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'favorites_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE favorites(id INTEGER PRIMARY KEY, login TEXT, avatarUrl TEXT, location TEXT, email TEXT, bio TEXT)",
        );
      },
      version: 1,
    );
  }
}