import 'dart:convert';

import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';
import 'package:mobile_challenge/app/shared/utils/prefs_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../infra/datasources/favorites_datasource.dart';
import '../infra/models/user_favorite_model.dart';

class LocalGetFavorites implements FavoritesDataSource {
  final SharedPreferences prefs;

  LocalGetFavorites(this.prefs);
  @override
  Future<List<UserFavoriteModel>> getFavorites() async {
    List<UserFavoriteModel> favorites = [];

    final savedFavorites = prefs.getString(PrefsKey.CACHED_FAVORITES);

    if (savedFavorites != null) {
        final items  = jsonDecode(savedFavorites)["favorites"];
         favorites = items.map((item) => 
          UserFavoriteModel.fromJson(item)).toList().cast<UserFavoriteModel>();
    }
    return favorites;
  }

  @override
  Future<bool> saveFavorites(UserFavorite user) {
    // TODO: implement saveFavorites
    throw UnimplementedError();
  }
}