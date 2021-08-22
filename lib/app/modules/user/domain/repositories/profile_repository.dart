import '../entities/user_detail_entity.dart';

abstract class ProfileRepository {
  Future<UserDetailEntity> getUserDetail(String username);
}