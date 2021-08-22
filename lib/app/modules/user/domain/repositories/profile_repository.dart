import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserDetail(String username);
}