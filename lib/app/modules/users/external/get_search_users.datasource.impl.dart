import 'package:mobile_challenge/app/modules/users/data/datasource/get_search_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/shared/failures/failure_system.dart';

class GetSearchUsersDatasourceImpl implements GetSearchUsersDatasource {
  final Dio _dio;
  GetSearchUsersDatasourceImpl(this._dio);

  @override
  Future<List<UserModel>> call(String text, int page) async {
    int perPage = 15;
    String route = '/search/users';
    Map<String, dynamic> queryParameters = {
      "q": text,
      "per_page": perPage,
      "page": page
    };
    try {
      var result = await _dio.get(route, queryParameters: queryParameters);
      List responseJson = result.data["items"];
      return responseJson.map((item) => UserModel.fromJson(item)).toList();
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
