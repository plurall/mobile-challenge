import 'package:mobile_challenge/app/shared/domain/Entities/user_details_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

String nomeTable = 'favoritos';

String idColumn = 'id';
String nomeColumn = 'name';
String localizacaoColumn = 'location';
String bioColumn = 'bio';
String emailColumn = 'email';

class FavoritoCacheDb {

  static final FavoritoCacheDb _instance = FavoritoCacheDb.internal();

  factory FavoritoCacheDb() => _instance;

  FavoritoCacheDb.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "favoritos.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $nomeTable($idColumn INTEGER, $nomeColumn TEXT, $localizacaoColumn TEXT, $bioColumn TEXT, $emailColumn TEXT)"
      );
    });
  }

  Future<UserSingle> saveFavorito(UserSingle user) async {
    Database dbContact = await db;
    Map<String,dynamic> dados = {
      'id' : user.id,
      'name': user.name,
      'location': user.location,
      'bio': user.bio,
      'email': user.email,
    };
    user.id = await dbContact.insert(nomeTable, dados);
    return user;
  }


  Future<int> deleteFavorito(UserSingle user) async {
    Database dbContact = await db;
    return await dbContact.delete(nomeTable, where: "$idColumn = ?", whereArgs: [user.id]);
  }


  Future<List<UserSingle>> getAllFavoritos() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $nomeTable");
    List<UserSingle> listContact = [];
    for(Map m in listMap){
      listContact.add(UserSingle.fromJson(m));
    }
    return listContact;
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}