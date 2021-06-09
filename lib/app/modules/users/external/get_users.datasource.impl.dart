import 'package:mobile_challenge/app/modules/users/data/datasource/get_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/shared/failures/failure_system.dart';

class GetUsersDatasourceImpl implements GetUsersDatasource {
  final Dio _dio;
  GetUsersDatasourceImpl(this._dio);

  @override
  Future<List<UserModel>> call(String text) async {
    try {
      var result = await _dio.get('/users/$text');
      if (result.statusCode == 200) {
        List responseJson = result.data;
        return responseJson.map((item) {
          return UserModel.fromJson(item);
        }).toList();
      } else {
        return throw FailureSystem(type: ErrorSystem.CONNECTION);
      }
    } catch (error) {
      return throw FailureSystem(type: ErrorSystem.CONNECTION);
    }
  }
}
