import 'package:mobile_challenge/shared/entities/User.dart';

class UserSearchResponseModel {
  final List<User> users;
  final bool hasMore;

  UserSearchResponseModel(this.users, this.hasMore);
}
