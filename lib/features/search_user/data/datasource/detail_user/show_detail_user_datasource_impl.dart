import 'package:dio/dio.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/detail_user/show_detail_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/data/models/detail_user_model.dart';

class ShowDetailUserDatasourceImpl implements IShowDetailUserDataSource {
  final Dio dio;

  ShowDetailUserDatasourceImpl(this.dio);

  @override
  Future<DetailUserModel> showDetailUser(String text) async {
    this.dio.interceptors.add(LogInterceptor());
    var result = await this.dio.get(
          'https://api.github.com/users/$text',
        );
    if (result.statusCode == 200) {
      result.data['image'] = result.data['avatar_url'];
      result.data['nickname'] = result.data['login'];

      return DetailUserModel.fromJson(result.data);
    } else {
      throw Exception();
    }
  }
}
