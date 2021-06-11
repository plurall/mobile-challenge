import 'package:mobile_challenge/app/modules/users/data/datasource/get_user.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/shared/failures/failure_system.dart';

class GetUserDatasourceImpl implements GetUserDatasource {
  final Dio _dio;
  GetUserDatasourceImpl(this._dio);

  @override
  Future<UserModel> call(int id) async {
    String route = '/user/' + id.toString();
    try {
      var result = await _dio.get(route);
      return UserModel.fromJson(result.data);
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
