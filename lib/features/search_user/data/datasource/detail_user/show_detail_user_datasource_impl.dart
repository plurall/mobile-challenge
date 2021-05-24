import 'package:dio/dio.dart';
import 'package:mobile_challenge/core/helper/db_helper.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/detail_user/show_detail_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/data/models/detail_user_model.dart';

class ShowDetailUserDatasourceImpl implements IShowDetailUserDataSource {
  final Dio dio;
  final DBHelper dbHelper;

  ShowDetailUserDatasourceImpl(this.dio, this.dbHelper);

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

  @override
  Future<List<DetailUserModel>> gelAllFavoriteLocal() async {
    try {
      var result = await this.dbHelper.getData();
      var list = result
          .map(
            (item) => DetailUserModel(
              image: item['image'],
              nickname: item['nickname'],
              bio: item['bio'],
              email: item['email'],
              location: item['location'],
            ),
          )
          .toList();
      return list;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> saveFavoriteLocal(DetailUserModel detailUserModel) async {
    await dbHelper.insert(detailUserModel.toJson());
  }
}
