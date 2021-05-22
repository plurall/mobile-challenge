import 'package:mobile_challenge/app/api/dio/custom_dio.dart';
import 'package:mobile_challenge/app/api/response/base_model.dart';
import 'package:mobile_challenge/app/shared/model/search/serach_model.dart';

class CommonRepository {
  Future<BaseModel<SearchModel>> fecthSearchUsers(String search) async {
    try {
      final dio = await CustomDio().init();
      final response = await dio.get('search/users?q=$search');
      return BaseModel()
        ..data = SearchModel.fromJson(response.data as Map<String, dynamic>);
    } catch (dioError) {
      return BaseModel()..exception = dioError;
    }
  }
}
