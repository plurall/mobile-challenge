import 'package:mobile_challenge/app/models/favorites_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabaseService {
  static final FavoriteDatabaseService instance =
      FavoriteDatabaseService._init();

  static Database _database;

  FavoriteDatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('favorites.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableFavorites ( 
  ${FavoritesFields.id} $idType,
  ${FavoritesFields.login} $textType,
  ${FavoritesFields.email} $textType,
  ${FavoritesFields.location} $textType,
  ${FavoritesFields.bio} $textType
  )
''');
  }

  Future<FavoritesModel> create(FavoritesModel favorite) async {
    final db = await instance.database;

    final id = await db.insert(tableFavorites, favorite.toJson());
    return favorite.copy(id: id);
  }

  Future<FavoritesModel> findOne(String login) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorites,
      columns: FavoritesFields.values,
      where: '${FavoritesFields.login} = ?',
      whereArgs: [login],
    );

    if (maps.isNotEmpty) {
      return FavoritesModel.fromJson(maps.first);
    } else {
      throw Exception('Login $login not found');
    }
  }

  Future<List<FavoritesModel>> findAll() async {
    final db = await instance.database;

    final orderBy = '${FavoritesFields.login} ASC';

    final result = await db.query(tableFavorites, orderBy: orderBy);
    // final result = await db.query(tableFavorites);

    return result.map((json) => FavoritesModel.fromJson(json)).toList();
  }

  Future<int> update(FavoritesModel favorite) async {
    final db = await instance.database;

    return db.update(
      tableFavorites,
      favorite.toJson(),
      where: '${FavoritesFields.id} = ?',
      whereArgs: [favorite.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFavorites,
      where: '${FavoritesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }
}
