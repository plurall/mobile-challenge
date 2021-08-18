import 'dart:convert';

import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/users_favorite_model.dart';
import 'package:mobile_challenge/app/shared/utils/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infra/datasources/favorites_datasource.dart';
import '../infra/models/user_favorite_model.dart';

class LocalGetFavorites implements FavoritesDataSource {
  final SharedPreferences prefs;

  LocalGetFavorites(this.prefs);
  @override
  Future<List<UserFavoriteModel>> getFavorites() async {
    final savedFavorites = prefs.getString(PrefsKey.CACHED_FAVORITES);

    if (savedFavorites != null) {
        final favorites = UsersFavoriteModel.fromMap(jsonDecode(savedFavorites)).favorites;
        return favorites;
    }

    throw Exception();
  }

  @override
  Future<bool> saveFavorites(UserFavorite user) async {
    // final userModel = UserFavoriteModel.fromEntity(user);
    // final favorites = await getFavorites();
    // final alreadyAdded = _checkIfAlreadyFavorite(userModel, favorites);

    // if (alreadyAdded) throw FavoriteAlreadyExists();

    // favorites.add(userModel);
    // Map<String,dynamic> json = {
    //   "favorites": favorites.map((item) => item.toJson())
    // };
    // await prefs.setString(PrefsKey.CACHED_FAVORITES, jsonEncode(json));
    return true;
  }

  bool _checkIfAlreadyFavorite(UserFavoriteModel user, List<UserFavoriteModel> favorites) {
    for (final favorite in favorites) {
        if (favorite.location == user.login) {
            return true;
        }        
    }
    return false;
  }
}