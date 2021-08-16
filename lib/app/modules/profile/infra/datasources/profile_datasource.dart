import '../../domain/entities/user_detail_entity.dart';

abstract class ProfileDatasource {
  Future<UserDetailEntity> getUser(String username);
}