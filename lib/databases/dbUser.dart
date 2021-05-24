import 'package:mobile_challenge/models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;

  static final tabelaNome = 'usersFavoritos';

  DataBaseHelper.internal();

  String createdUsersTableScript = 'CREATE TABLE $tabelaNome(' +
      'id INTEGER PRIMARY KEY, ' +
      'login TEXT, ' +
      'node_id TEXT, ' +
      'avatar_url TEXT, ' +
      'gravatar_id TEXT, ' +
      'url TEXT, ' +
      'html_url TEXT, ' +
      'followers_url TEXT, ' +
      'following_url TEXT, ' +
      'gists_url TEXT, ' +
      'starred_url TEXT, ' +
      'subscriptions_url TEXT, ' +
      'organizations_url TEXT, ' +
      'repos_url TEXT, ' +
      'events_url TEXT, ' +
      'received_events_url TEXT, ' +
      'type TEXT, ' +
      'site_admin BOOL, ' +
      'name TEXT, ' +
      'company TEXT, ' +
      'blog TEXT, ' +
      'location TEXT, ' +
      'email TEXT, ' +
      'hireable BOOL, ' +
      'bio TEXT, ' +
      'twitter_username TEXT, ' +
      'public_repos TEXT, ' +
      'public_gists TEXT, ' +
      'followers INTEGER, ' +
      'following INTEGER, ' +
      'created_at TEXT, ' +
      'updated_at TEXT ' +
      ')';

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

  Future<List<User>> getAllUsers() async {
    try {
      final Database db = await initDb();
      final List<Map<String, dynamic>> maps = await db.query(tabelaNome);

      return List.generate(
        maps.length,
        (i) {
          return User.fromJson(maps[i]);
        },
      );
      
      //List<User> list =
      //    maps.isNotEmpty ? maps.map((c) => User.fromJson(c)).toList() : [];
      // return list;
    } catch (e) {
      print("erro =>> $e");
      return List.empty();
    }
  }

  Future<void> insertUser(User user) async {
    final db = await initDb();

    try {
      await db.insert(
        '$tabelaNome',
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(int id) async {
    final db = await initDb();

    try {
      await db.delete(
        '$tabelaNome',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }
}
