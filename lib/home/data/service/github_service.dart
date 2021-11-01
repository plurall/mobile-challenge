import 'package:mobile_challenge/home/data/models/user_model.dart';

abstract class GithubService {
  Future<List<UserModel>> findAll(String searchQuery);
  Future<UserModel> findById(int id);
}