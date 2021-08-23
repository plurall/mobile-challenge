import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/models/user_model.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';

class FavoritesController extends GetxController {
  FavoritesController({@required this.repository}) : assert(repository != null);
  final Repository repository;

  List<UserModel> get favoritesList => _$favoritesList();
  final RxList<UserModel> _$favoritesList = RxList();

  bool get isSearching => _$isSearching.value;
  final _$isSearching = true.obs;

  @override
  void onInit() {
    loadFavoritesList();
    super.onInit();
  }

  void loadFavoritesList() {
    try {
      _$isSearching(true);
      final data = repository.getAllFavorite();
      _$favoritesList(data);
    } catch (e) {
      print(e);
    } finally {
      _$isSearching(false);
    }
  }
}
