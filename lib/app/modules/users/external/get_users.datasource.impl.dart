import 'package:mobile_challenge/app/core/shared/failures/failure_system.dart';
import 'package:mobile_challenge/app/modules/users/data/datasource/get_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';

class GetUsersDatasourceImpl implements GetUsersDatasource {
  static const String ROUTE = '/users';
  static const int PER_PAGE = 15;

  final Dio _dio;
  GetUsersDatasourceImpl(this._dio);

  @override
  Future<List<UserModel>> call(int id) async {
    Map<String, dynamic> queryParameters = {"per_page": PER_PAGE, "since": id};
    try {
      var result = await _dio.get(ROUTE, queryParameters: queryParameters);
      List responseJson = result.data;
      return responseJson.map((item) => UserModel.fromJson(item)).toList();
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
