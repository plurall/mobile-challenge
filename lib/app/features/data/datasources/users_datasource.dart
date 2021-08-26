import 'package:mobile_challenge/app/features/domain/entities/user.dart';

abstract class UsersDatasource {
  Future<User> getUser(String username);
}
