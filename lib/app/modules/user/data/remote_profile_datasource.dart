import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_challenge/app/shared/utils/endpoints.dart';

import '../domain/errors/profile_errors.dart';
import '../infra/datasources/profile_datasource.dart';
import '../infra/models/user_detail_model.dart';

class RemoteProfileDatasourceImpl implements RemoteProfileDatasource {
  final Client http;

  RemoteProfileDatasourceImpl(this.http);  
  @override
  Future<UserDetailModel> getUser(String username) async {
    final endpoint = Endpoints.userDetail + username;

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final users = UserDetailModel.fromJson(body);

        return users;
    } else if (response.statusCode == 401) {
      throw UnauthorizedError();
    }
     else {
      throw Exception();
    }

  }
  
}