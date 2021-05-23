import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/api/repository/common_repository.dart';
import 'package:mobile_challenge/app/shared/model/user/user_model.dart';
import 'package:stacked/stacked.dart';

class UserDetailsViewModel extends BaseViewModel {
  BuildContext context;
  CommonRepository _repository;
  UserModel userModel;
  String login;

  UserDetailsViewModel(this.context, this.login) {
    _repository = CommonRepository();
  }

  Future fecthUserDetailAsync() async {
    if (hasError) clearErrors();
    final result = await runBusyFuture(_fecthUserDetailBusyFuture());
    if (result is UserModel) userModel = result;
  }

  Future<UserModel> _fecthUserDetailBusyFuture() async {
    final request = await _repository.fecthUser(login);
    if (request.exception == null) {
      return request.data;
    } else {
      throw request.exception;
    }
  }
}
