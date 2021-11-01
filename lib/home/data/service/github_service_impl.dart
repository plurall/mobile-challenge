import 'package:dio/dio.dart';
import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mobile_challenge/home/data/service/github_service.dart';

class GithubServiceImpl implements GithubService {
  final String _baseUrl = 'https://api.github.com';
  final Dio _dio;

  GithubServiceImpl(this._dio);

  @override
  Future<List<UserModel>> findAll(String searchQuery) async {
    final response = await _dio.get('$_baseUrl/search/users', queryParameters: {
      'q': searchQuery,
    });

    return List<UserModel>.from(
        response.data["items"].map((x) => UserModel.fromJson(x))).toList();
  }

  @override
  Future<UserModel> findById(int id) async {
    final response = await _dio.get('$_baseUrl/user/$id');
    return UserModel.fromJson(response.data);
  }
}
