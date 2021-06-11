import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/do_favorite_user.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_user.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/remove_favorite_user.usecase.dart';
import 'package:mobile_challenge/app/shared/utils/constants.dart';
import 'package:mobile_challenge/app/shared/widgets/alert_system.widget.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'user_detail_controller.g.dart';

@Injectable()
class UserDetailController = _UserDetailControllerBase
    with _$UserDetailController;

abstract class _UserDetailControllerBase with Store {
  final GetUserUsecase _usecase;
  final DoFavoriteUserUsecase _doFavoriteUsecase;
  final RemoveFavoriteUserUsecase _removeFavoriteUsecase;
  _UserDetailControllerBase(
      this._usecase, this._doFavoriteUsecase, this._removeFavoriteUsecase);

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  bool isError = false;

  @action
  changeError(value) => isError = value;

  @observable
  UserEntity user;

  @action
  changeUser(value) => user = value;

  int id;
  bool isLocal = false;

  getUser() async {
    changeError(false);
    changeLoading(true);
    var result = await _usecase(id);
    result.fold(
        (error) => changeError(true), (response) => changeUser(response));
    changeLoading(false);
  }

  doFavoriteUser(context) async {
    changeLoading(true);
    var result = await _doFavoriteUsecase(user);
    changeLoading(false);
    result.fold(
        (error) => {
              AlertSystem().normal(
                  title: Constants.ATTENTION,
                  subTitle: Constants.ERROR_FAVORITE_USER,
                  successName: Constants.OK,
                  context: context,
                  onSuccess: () {})
            }, (response) {
      AlertSystem().normal(
          title: Constants.SUCCESS,
          subTitle: Constants.FAVORITE_USER,
          successName: Constants.OK,
          context: context,
          onSuccess: () {});
    });
  }

  removeFavoriteUser(context) async {
    changeLoading(true);
    var result = await _removeFavoriteUsecase(user.id);
    changeLoading(false);
    result.fold(
        (error) => {
              AlertSystem().normal(
                  title: Constants.ATTENTION,
                  subTitle: Constants.ERROR_REMOVE_FAVORITE_USER,
                  successName: Constants.OK,
                  context: context,
                  onSuccess: () {})
            }, (response) {
      AlertSystem().normal(
          title: Constants.SUCCESS,
          subTitle: Constants.REMOVE_FAVORITE_USER,
          successName: Constants.OK,
          context: context,
          onSuccess: () {
            Navigator.pop(context);
          });
    });
  }
}
