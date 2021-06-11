import 'package:mobile_challenge/app/core/shared/failures/failure_system.dart';
import 'package:mobile_challenge/app/modules/users/data/datasource/get_user.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';

class GetUserDatasourceImpl implements GetUserDatasource {
  static const String ROUTE = '/user/';

  final Dio _dio;
  GetUserDatasourceImpl(this._dio);

  @override
  Future<UserModel> call(int id) async {
    String route = ROUTE + id.toString();
    try {
      var result = await _dio.get(route);
      return UserModel.fromJson(result.data);
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
