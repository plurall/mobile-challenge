import 'dart:convert';
import 'user_detail_model.dart';


class UsersFavoriteModel {
  List<UserDetailModel> favorites;
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
      favorites: List<UserDetailModel>.from(map['favorites'].map((x) => UserDetailModel.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());
}
