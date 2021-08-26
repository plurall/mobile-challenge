import '../../domain/entities/user.dart';

abstract class UsersDriver {
  Future<List<User>> getFavoritesUsers();
  Future<bool> saveFavoritesUser(User user);
}
