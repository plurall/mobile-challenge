import 'package:mobile_challenge/app/modules/users/data/datasource/get_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/shared/failures/failure_system.dart';

class GetUsersDatasourceImpl implements GetUsersDatasource {
  final Dio _dio;
  GetUsersDatasourceImpl(this._dio);

  @override
  Future<List<UserModel>> call(int id) async {
    int perPage = 15;
    Map<String, dynamic> queryParameters = {"per_page": perPage, "since": id};
    String route = '/users';
    try {
      var result = await _dio.get(route, queryParameters: queryParameters);
      List responseJson = result.data;
      return responseJson.map((item) => UserModel.fromJson(item)).toList();
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
