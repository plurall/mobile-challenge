import 'package:mobile_challenge/app/models/profile_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteHelper {
  static final FavoriteHelper _favoriteHelper =
  FavoriteHelper._internal();

  Database _db;

  factory FavoriteHelper() {
    return _favoriteHelper;
  }

  FavoriteHelper._internal() {}

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initializeDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql =
        " CREATE TABLE favorite (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR , email VARCHAR, avatar_url VARCHAR, bio VARCHAR, location VARCHAR)";
    await db.execute(sql);
  }

  _initializeDB() async {
    final pathDB = await getDatabasesPath();
    final localDB = join(pathDB, "favorite.db");

    var db = await openDatabase(localDB, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> saveFavorite(ProfileModel perfilModel) async {
    var dataBase = await db;
    var id = await dataBase.insert("favorite",perfilModel.toMap());
    return id;
  }

  Future<List> getFavorites() async{
    var dataBase = await db;
    String sql;
    sql = "SELECT * FROM favorite";

    List favorites = await dataBase.rawQuery(sql);
    return favorites;
  }

  Future<int> removeFavorite(int id) async{
    var dataBase = await db;
    return await dataBase.delete(
        'favorite',
        where : " id=?",
        whereArgs:[id]
    );
  }
}
