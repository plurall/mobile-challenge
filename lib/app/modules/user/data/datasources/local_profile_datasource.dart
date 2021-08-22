import '../models/user_detail_model.dart';

abstract class LocalProfileDatasource {
  Future<UserDetailModel> getUser(String username);
  Future<void> cacheUser(UserDetailModel user);
}