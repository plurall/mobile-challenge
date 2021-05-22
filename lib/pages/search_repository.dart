import 'package:dio/dio.dart';
import 'package:mobile_challenge/model/result_search.dart';
import 'package:mobile_challenge/shared/custom_dio/custom_dio.dart';

class SearchRepository {
  final CustomDio _client;

  SearchRepository(this._client);

  Future<List<Items>> searchText(String text) async {
    try {
      var response = await _client.getDio().get('/users?q=$text');
      return (response.data['items'] as List)
          .map((i) => Items.fromJson(i))
          .toList();
    } on DioError catch (error) {
      throw (error.message);
    }
  }
}
