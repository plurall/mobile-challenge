import 'package:dio/dio.dart';
import 'package:mobile_challenge/model/ResultSearch.dart';
import 'package:mobile_challenge/shared/custom_dio/custom_dio.dart';

class SearchRepository {
  final CustomDio _client;

  SearchRepository(this._client);

  Future<ResultSearch> searchText(String text) async {
    try {
      var response = await _client.getDio().get('/users?q=$text');
      return ResultSearch.fromJson(response.data);
    } on DioError catch (error) {
      throw (error.message);
    }
  }
}
