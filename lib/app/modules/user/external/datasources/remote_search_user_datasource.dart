import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/utils/endpoints.dart';
import '../../data/datasources/search_user_datasource.dart';
import '../../data/models/searched_user_model.dart';
import '../../domain/errors/search_errors.dart';


class RemoteSearchUserDataSource implements SearchUserDataSource {
  final Client http;

  RemoteSearchUserDataSource(this.http);
  @override
  Future<List<SearchedUserModel>> search(String searchText) async {
    final endpoint = Endpoints.searchUser + searchText;

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final items = body["items"] as List;

        final users = items.map((item) => SearchedUserModel.fromMap(item)).toList();

        return users;
    } else if (response.statusCode == 503) {
       throw UnavailableServiceError();
    }
    else {
      throw Exception();
    }
  }
}