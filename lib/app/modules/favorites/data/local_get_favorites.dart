import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../infra/datasources/get_favorites_datasource.dart';
import '../infra/models/user_favorite_model.dart';

class LocalGetFavorites implements GetFavoritesDataSource {
  final SharedPreferences prefs;

  LocalGetFavorites(this.prefs);
  @override
  Future<List<UserFavoriteModel>> getFavorites() async {
    List<UserFavoriteModel> favorites = [];

    final savedFavorites = prefs.getString("favorites");

    if (savedFavorites != null) {
        final items  = jsonDecode(savedFavorites)["favorites"];
         favorites = items.map((item) => 
          UserFavoriteModel.fromJson(item)).toList().cast<UserFavoriteModel>();
    }
    return favorites;
  }
}