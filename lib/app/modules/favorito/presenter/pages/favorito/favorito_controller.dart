import 'dart:async';

import 'package:mobile_challenge/app/shared/domain/Entities/user_details_model.dart';
import 'package:mobile_challenge/app/shared/infra/datasources/favorito_cache.dart';

class FavoritoController {
  final FavoritoCacheDb favoritoCacheDb;

  FavoritoController({
    this.favoritoCacheDb
  });
  
  final _favoritosController = StreamController<List<UserSingle>>();
  Sink<List<UserSingle>> get favoritosIn => _favoritosController.sink;
  Stream<List<UserSingle>> get favoritosOut => _favoritosController.stream;

  getAllFavoritos() async {
    List<UserSingle> dados = await favoritoCacheDb.getAllFavoritos();
    favoritosIn.add(dados);
  }

  deletarFavorito(UserSingle user) async {
    await favoritoCacheDb.deleteFavorito(user);
  }

  dispose(){
    _favoritosController.close();
  }
}