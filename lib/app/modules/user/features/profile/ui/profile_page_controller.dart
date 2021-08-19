import 'package:mobx/mobx.dart';

import '../domain/entities/user_detail_entity.dart';
import '../domain/usecases/user_profile.dart';

part 'profile_page_controller.g.dart';

class ProfilePageController = _ProfilePageControllerBase with _$ProfilePageController;
enum ProfilePageState {IDLE, LOADING}

abstract class _ProfilePageControllerBase with Store {
  final UserProfile usecase;

  @observable
  UserDetailEntity? userDetail;

  @observable
  ProfilePageState state = ProfilePageState.LOADING;

  _ProfilePageControllerBase(this.usecase);


  @action
  Future<Null> getUserDetail(String username) async {
    state = ProfilePageState.LOADING;
    userDetail  = await usecase.getUserDetail(username);
    state = ProfilePageState.IDLE;
  }

}