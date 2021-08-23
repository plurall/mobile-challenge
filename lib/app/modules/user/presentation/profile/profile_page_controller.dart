import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/core/error/failures.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/remove_favorite.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/save_favorite.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/verify_favorite.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_profile.dart';

part 'profile_page_controller.g.dart';

class ProfilePageController = _ProfilePageControllerBase with _$ProfilePageController;
enum ProfilePageState {IDLE, LOADING, NO_INTERNET}

abstract class _ProfilePageControllerBase with Store {
  final UserProfile userProfileUsecase;
  final VerifyFavorite verifyFavoriteUsecase;
  final SaveFavorite saveFavoriteUsecase;
  final RemoveFavorite removeFavoriteUsecase;

  @observable
  UserEntity? userDetail;

  @observable
  bool isFavorite = false;

  @observable
  ProfilePageState state = ProfilePageState.LOADING;

  _ProfilePageControllerBase({
    required this.userProfileUsecase, 
    required this.verifyFavoriteUsecase, 
    required this.saveFavoriteUsecase, 
    required this.removeFavoriteUsecase 
  });

  @action
  Future<Null> getUserDetail(String username) async {
    state = ProfilePageState.LOADING;

    try {
      userDetail = await userProfileUsecase(username);

      isFavorite = await verifyFavoriteUsecase(userDetail!);

      state = ProfilePageState.IDLE;
    } on CacheFailure {
      state = ProfilePageState.NO_INTERNET;
    }
  }

  @action
  Future<Null> saveFavorite() async {
    await saveFavoriteUsecase(userDetail!);

    isFavorite = true;

    return;
  }

  @action
  Future<Null> removeFavorite() async {
    await removeFavoriteUsecase(userDetail!);

    isFavorite = false;

    return;
  }

}