import 'dart:convert';
import 'package:mobile_challenge/app/core/erros/exceptions.dart';
import 'package:mobile_challenge/app/common/constants/app_urls.dart';
import 'package:mobile_challenge/app/core/httpClient/http_client.dart';
import 'package:mobile_challenge/app/modules/users_search/data/model/user_list_model.dart';

abstract class IUserSearchDataSource {
  Future<UserListModel> userSearch(String searchTerm);
}

class UserSearchDataSource implements IUserSearchDataSource {
  final IHttpClient client;

  UserSearchDataSource(this.client);

  @override
  Future<UserListModel> userSearch(String searchTerm) async {
    final response = await client.get(AppUrl.userSearchUrl(searchTerm));

    if (response.statusCode == 200) {
      return UserListModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException(message: 'Error datasource');
    }

    // Mock implementation
    // final mockFile = 'users_search';
    // final mockData = await Future.delayed(
    //   const Duration(seconds: 3),
    //   () => MockUtils.getMock(mockFile),
    // );

    // if (mockData != null) {
    //   return UserListModel.fromJson(mockData);
    // } else {
    //   throw ServerFailure(message: 'Error datasource');
    // }
  }
}
