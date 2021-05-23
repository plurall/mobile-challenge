import 'package:dio/dio.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/search_user/search_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/data/models/user_model.dart';

class SearchUserDatasourceImpl implements ISerchUserDatasource {
  final Dio dio;

  SearchUserDatasourceImpl(this.dio);

  @override
  Future<List<UserModel>> searchUserByText(String text) async {
    this.dio.interceptors.add(LogInterceptor());
    var result = await this.dio.get(
          'https://api.github.com/search/users?q=${text.trim().replaceAll(' ', '+')}',
        );
    if (result.statusCode == 200) {
      var jsonList = result.data['items'] as List;
      var list = jsonList
          .map(
            (item) => UserModel(
              nickname: item['login'],
              image: item['avatar_url'],
            ),
          )
          .toList();

      return list;
    } else {
      throw Exception();
    }
  }
}
