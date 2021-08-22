import 'dart:convert';

import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/utils/prefs_key.dart';
import '../domain/errors/favorites_errors.dart';
import '../infra/datasources/favorites_datasource.dart';
import '../infra/models/users_detail_model.dart';

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
  Future<bool> saveFavorite(UserDetailEntity user) async {
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
  Future<bool> removeFavorite(UserDetailEntity user) async {
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
  Future<bool> verifyFavorite(UserDetailEntity user) async {
    try {
      await getFavorites();
    } catch (error){}

    final isFavorite = favorites.indexWhere((favorite) => favorite.login == user.login) != -1; 

    return isFavorite;
  }

}