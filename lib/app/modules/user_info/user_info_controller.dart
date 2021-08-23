import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/models/user_model.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';

class UserInfoController extends GetxController {
  UserInfoController({@required this.repository}) : assert(repository != null);

  final Repository repository;

  bool get isSearching => _$isSearching.value;
  final _$isSearching = true.obs;

  UserModel get user => _$user.value;
  set user(UserModel value) => _$user.value = value;
  final Rx<UserModel> _$user = Rxn();

  bool get isFavorite => _$isFavorite();
  set isFavorite(bool value) => _$isFavorite(value);
  final RxBool _$isFavorite = false.obs;

  String _username;

  @override
  void onInit() {
    _verifyArguments();
    loadUserInfo();
    super.onInit();
  }

  void _verifyArguments() {
    assert(
      Get.arguments != null,
      'Você precisa passar o username',
    );
    _username = Get.arguments;
    assert(
      _username is String,
      'O argumento precisa ser uma string',
    );
  }

  loadUserInfo() async {
    try {
      _$isSearching(true);
      final UserModel res = repository.getFavorite(username: _username);
      if (res != null) {
        _$isFavorite(true);
        _$user(res);
      } else {
        final UserModel data = await repository.getUser(name: _username);
        _$user(data);
      }
    } catch (e) {
      print(e);
    } finally {
      _$isSearching(false);
    }
  }

  onPressFavorite() {
    try {
      if (isFavorite) {
        repository.removeFavorite(username: user.login);
      } else {
        repository.addFavorite(user: user);
      }
    } catch (e) {
      print(e);
    } finally {
      Get.until((route) => route.isFirst);
    }
  }
}
