import 'package:mobile_challenge/home/domain/entity/user.dart';

abstract class GithubService {
  Future<List<User>> findAll(String searchQuery);
  Future<User> findById(int id);
}