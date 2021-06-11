import 'package:mobile_challenge/app/core/shared/failures/failure_system.dart';
import 'package:mobile_challenge/app/modules/users/data/datasource/get_search_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';

class GetSearchUsersDatasourceImpl implements GetSearchUsersDatasource {
  static const String ROUTE = '/search/users';
  static const int PER_PAGE = 15;

  final Dio _dio;
  GetSearchUsersDatasourceImpl(this._dio);

  @override
  Future<List<UserModel>> call(String text, int page) async {
    Map<String, dynamic> queryParameters = {
      "q": text,
      "per_page": PER_PAGE,
      "page": page
    };
    try {
      var result = await _dio.get(ROUTE, queryParameters: queryParameters);
      List responseJson = result.data["items"];
      return responseJson.map((item) => UserModel.fromJson(item)).toList();
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
