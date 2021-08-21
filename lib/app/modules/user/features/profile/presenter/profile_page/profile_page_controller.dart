import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/usecases/remove_favorite.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/usecases/save_favorite.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/usecases/verify_favorite.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/user_detail_entity.dart';
import '../../domain/usecases/user_profile.dart';

part 'profile_page_controller.g.dart';

class ProfilePageController = _ProfilePageControllerBase with _$ProfilePageController;
enum ProfilePageState {IDLE, LOADING}

abstract class _ProfilePageControllerBase with Store {
  final UserProfile userProfileUsecase = Modular.get();
  final VerifyFavorite verifyFavoriteUsecase = Modular.get();
  final SaveFavorite saveFavoriteUsecase = Modular.get();
  final RemoveFavorite removeFavoriteUsecase = Modular.get();

  @observable
  UserDetailEntity? userDetail;

  @observable
  bool isFavorite = false;

  @observable
  ProfilePageState state = ProfilePageState.LOADING;



  @action
  Future<Null> getUserDetail(String username) async {
    state = ProfilePageState.LOADING;

    userDetail = await userProfileUsecase(username);

    isFavorite = await verifyFavoriteUsecase(userDetail!);

    state = ProfilePageState.IDLE;
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