import 'package:mobile_challenge/data/model/user_summary.dart';

class Utils {
  static bool isFavoriteUser(
          List<UserSummary> favoriteUsers, UserSummary user) =>
      favoriteUsers.where((current) => current.id == user.id).isNotEmpty;
}
