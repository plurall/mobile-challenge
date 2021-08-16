import 'package:mobile_challenge/app/modules/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/profile/domain/errors/profile_errors.dart';
import 'package:mobile_challenge/app/modules/profile/domain/repositories/profile_repository.dart';

abstract class UserProfile {
  Future<UserDetailEntity> getUserDetail (String username);
}

class UserProfileImpl implements UserProfile {
  final ProfileRepository repository;

  UserProfileImpl(this.repository);

  @override
  Future<UserDetailEntity> getUserDetail(String username) async {
    if (username.isEmpty || username.contains(" ")) {
        throw InvalidUserName();
    }
    final result = await repository.getUserDetail(username);
    return result;
  }

}