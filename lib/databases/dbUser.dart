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
      'nodeId TEXT, ' +
      'avatarUrl TEXT, ' +
      'gravatarId TEXT, ' +
      'url TEXT, ' +
      'htmlUrl TEXT, ' +
      'followersUrl TEXT, ' +
      'followingUrl TEXT, ' +
      'gistsUrl TEXT, ' +
      'starredUrl TEXT, ' +
      'subscriptionsUrl TEXT, ' +
      'organizationsUrl TEXT, ' +
      'reposUrl TEXT, ' +
      'eventsUrl TEXT, ' +
      'receivedEventsUrl TEXT, ' +
      'type TEXT, ' +
      'siteAdmin BOOL, ' +
      'name TEXT, ' +
      'company TEXT, ' +
      'blog TEXT, ' +
      'location TEXT, ' +
      'email TEXT, ' +
      'hireable BOOL, ' +
      'bio TEXT, ' +
      'twitterUsername TEXT, ' +
      'publicRepos TEXT, ' +
      'publicGists TEXT, ' +
      'followers INTEGER, ' +
      'following INTEGER, ' +
      'createdAt TEXT, ' +
      'updatedAt TEXT ' +
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

  Future create(User user) async {
    try {
      final Database db = await initDb();

      await db.insert(
        tabelaNome,
        user.toJson(),
      );
    } catch (ex) {
      print(ex);
      return;
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
    } catch (ex) {
      print(ex);
      return new List<User>();
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

    await db.delete(
      '$tabelaNome',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
