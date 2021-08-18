import 'dart:convert';

import 'package:mobile_challenge/app/modules/favorites/infra/models/user_favorite_model.dart';

class UsersFavoriteModel {
  List<UserFavoriteModel> favorites;
  UsersFavoriteModel({
    required this.favorites,
  });

  Map<String, dynamic> toMap() {
    return {
      'favorites': favorites.map((x) => x.toMap()).toList(),
    };
  }

  factory UsersFavoriteModel.fromMap(Map<String, dynamic> map) {
    return UsersFavoriteModel(
      favorites: List<UserFavoriteModel>.from(map['favorites'].map((x) => UserFavoriteModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
}
