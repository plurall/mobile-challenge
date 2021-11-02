import 'dart:convert';
import 'package:mobile_challenge/app/core/erros/exceptions.dart';
import 'package:mobile_challenge/app/core/httpClient/http_client.dart';
import 'package:mobile_challenge/app/modules/users_search/data/model/user_search_model.dart';

abstract class IUserDetailDataSource {
  Future<UserModel> userDetail(String detailUrl);
}

class UserDetailDataSource implements IUserDetailDataSource {
  final IHttpClient client;

  UserDetailDataSource(this.client);

  @override
  Future<UserModel> userDetail(String detailUrl) async {
    final response = await client.get(detailUrl);

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException(message: 'Error datasource');
    }
  }
}
