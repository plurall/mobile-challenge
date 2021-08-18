import 'dart:convert';

import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/errors/favorites_errors.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/users_favorite_model.dart';
import 'package:mobile_challenge/app/shared/utils/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infra/datasources/favorites_datasource.dart';
import '../infra/models/user_favorite_model.dart';

class LocalGetFavorites implements FavoritesDataSource {
  final SharedPreferences prefs;
  LocalGetFavorites(this.prefs);

  List<UserFavoriteModel> favorites = [];
  @override
  Future<List<UserFavoriteModel>> getFavorites() async {
    final savedFavorites = prefs.getString(PrefsKey.CACHED_FAVORITES);

    if (savedFavorites != null) {
        favorites = UsersFavoriteModel.fromMap(jsonDecode(savedFavorites)).favorites;
        return favorites;
    }

    throw Exception();
  }

  @override
  Future<bool> saveFavorite(UserFavorite user) async {    
    try {
      await getFavorites();
    } catch (error){}

    final userModel = UserFavoriteModel.fromEntity(user);
    final alreadyAdded = _checkIfAlreadyFavorite(userModel);

    if (alreadyAdded) throw FavoriteAlreadyExists();

    favorites.add(userModel);
    return await _updateFavoritesSharedPreferences();
  }

  @override
  Future<bool> removeFavorite(UserFavorite user) async{
    try {
      await getFavorites();
    } catch (error){}

    final index = favorites.indexWhere((item) => item.login == user.login);

    if (index == -1) throw FavoriteDoesntExists();

    favorites.removeAt(index);   

    return await _updateFavoritesSharedPreferences();
  }

  bool _checkIfAlreadyFavorite(UserFavoriteModel user) {
    for (final favorite in favorites) {
        if (favorite.location == user.login) {
            return true;
        }        
    }
    return false;
  }

  Future _updateFavoritesSharedPreferences() async {
    final newFavorites = UsersFavoriteModel(favorites: favorites);
    final json =  newFavorites.toJson();
    return await prefs.setString(PrefsKey.CACHED_FAVORITES, json);
  }

}