import 'package:mobile_challenge/data/model/user.dart';

class Utils {
  static bool isFavoriteUser(List<User> favoriteUsers, User user) =>
      favoriteUsers.where((current) => current.id == user.id).isNotEmpty;
}
