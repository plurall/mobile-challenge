import 'package:mobile_challenge/modules/search/infra/models/classeJson.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class FavoritosHelper {

  static final String nomeTabela = "favoritos";

  static final FavoritosHelper _favoritosHelper = FavoritosHelper._internal();
  Database _db;

  factory FavoritosHelper(){
    return _favoritosHelper;
  }

  FavoritosHelper._internal();
  get db async {

    if( _db != null ){
      return _db;
    }else{
      _db = await inicializarDB();
      return _db;
    }

  }

  _onCreate(Database db, int version) async {

    String sql = "CREATE TABLE $nomeTabela ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "idfavorito VARCHAR,"
        "login VARCHAR,"
        "location VARCHAR,"
        "bio VARCHAR, "
        "name VARCHAR, "
        "email VARCHAR)";
    await db.execute(sql);

  }

  inicializarDB() async {

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_meus_favoritos.db");

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate );
    return db;

  }

  Future<int> salvarFavorito(ClassJson favorito) async {

    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, favorito.toMap() );
    return resultado;

  }

  recuperarFavorito() async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela";
    List anotacoes = await bancoDados.rawQuery( sql );
    return anotacoes;

  }


  Future<int> removerFavorito( int id ) async {

    var bancoDados = await db;
    return await bancoDados.delete(
        nomeTabela,
        where: "id = ?",
        whereArgs: [id]
    );

  }


}
