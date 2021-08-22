import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/utils/endpoints.dart';
import '../../data/datasources/profile_datasource.dart';
import '../../data/models/user_detail_model.dart';
import '../../domain/errors/profile_errors.dart';

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