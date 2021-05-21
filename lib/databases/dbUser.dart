import 'package:mobile_challenge/models/Users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;

  static final tabelaNome = 'user';
  static final colId = 'id';
  static final colLogin = 'login';
  static final colIsFavorited = 'favorito';

  String createdUsersTableScript = 'CREATE TABLE $tabelaNome('
      '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$colLogin TEXT), '
      '$colIsFavorited BOOL;';

  DataBaseHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "mobile_challenge.db");

    try {
      return openDatabase(path, version: 1,
          onCreate: (Database db, int newerVersion) async {
        await db.execute(createdUsersTableScript);
      });
    } catch (e) {
      print(e);
      return _db;
    }
  }

  Future create(Users model) async {
    try {
      final Database db = await initDb();

      await db.insert(
        tabelaNome,
        model.toJson(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<Users>> getContacts() async {
    try {
      final Database db = await initDb();
      final List<Map<String, dynamic>> maps = await db.query(tabelaNome);

      return List.generate(
        maps.length,
        (i) {
          return Users.fromJson(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return new List<Users>();
    }
  }
}
