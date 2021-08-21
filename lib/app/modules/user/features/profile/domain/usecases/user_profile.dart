import '../entities/user_detail_entity.dart';
import '../errors/profile_errors.dart';
import '../repositories/profile_repository.dart';

abstract class UserProfile {
  Future<UserDetailEntity> call (String username);
}

class UserProfileImpl implements UserProfile {
  final ProfileRepository repository;

  UserProfileImpl(this.repository);

  @override
  Future<UserDetailEntity> call(String username) async {
    if (username.isEmpty || username.contains(" ")) {
        throw InvalidUserName();
    }
    final result = await repository.getUserDetail(username);
    return result;
  }

}