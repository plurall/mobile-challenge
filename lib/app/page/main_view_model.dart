
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/api/repository/common_repository.dart';
import 'package:mobile_challenge/app/shared/model/search/serach_model.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  BuildContext context;
  CommonRepository _repository;
  SearchModel searchModel;
  String currentSearch;

  MainViewModel(this.context) {
    _repository = CommonRepository();
  }

  Future fecthSearchUsersAsync() async {
    if (hasError) clearErrors();
    final result = await runBusyFuture(_fecthSearchBusyFuture());
    if (result is SearchModel) searchModel = result;
  }

  Future<SearchModel> _fecthSearchBusyFuture() async {
    final request = await _repository.fecthSearchUsers(currentSearch);
    if (request.exception == null) {
      return request.data;
    } else {
      throw request.exception;
    }
  }

  @override
  void onFutureError(error, Object key) {
    super.onFutureError(error, key);
    searchModel?.items?.clear();
  }
}