import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/prefs_key.dart';
import '../../data/datasources/favorites_datasource.dart';
import '../../data/models/user_detail_model.dart';
import '../../data/models/users_detail_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/errors/favorites_errors.dart';

class LocalFavoritesDatasource implements FavoritesDataSource {
  final SharedPreferences prefs;
  LocalFavoritesDatasource(this.prefs);

  List<UserDetailModel> favorites = [];
  @override
  Future<List<UserDetailModel>> getFavorites() async {
    final savedFavorites = prefs.getString(PrefsKey.CACHED_FAVORITES);

    if (savedFavorites != null) {
        UsersDetailModel model = UsersDetailModel.fromMap(json.decode(savedFavorites));
        favorites = model.users;
        return favorites;
    }

    throw Exception();
  }

  @override
  Future<bool> saveFavorite(UserEntity user) async {
    try {
      await getFavorites();
    } catch (error){}

    final userModel = UserDetailModel.fromEntity(user);

    final alreadyAdded = favorites.indexWhere((item) => item.login == user.login) != -1;

    if (alreadyAdded) throw FavoriteAlreadyExists();

    favorites.add(userModel);
    return await _updateFavoritesSharedPreferences();
  }

  @override
  Future<bool> removeFavorite(UserEntity user) async {
    try {
      await getFavorites();
    } catch (error){}

    final index = favorites.indexWhere((item) => item.login == user.login);

    if (index == -1) throw FavoriteDoesntExists();

    favorites.removeAt(index);   

    return await _updateFavoritesSharedPreferences();
  }

  Future _updateFavoritesSharedPreferences() async {
    final newFavorites = UsersDetailModel(users: favorites);
    final json =  newFavorites.toJson();
    return await prefs.setString(PrefsKey.CACHED_FAVORITES, json);
  }

  @override
  Future<bool> verifyFavorite(UserEntity user) async {
    try {
      await getFavorites();
    } catch (error){}

    final isFavorite = favorites.indexWhere((favorite) => favorite.login == user.login) != -1; 

    return isFavorite;
  }

}