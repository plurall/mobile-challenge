import 'package:mobile_challenge/shared/entities/User.dart';

class UserSearchApiModel {
  UserSearchApiModel();

  int totalCount;
  bool incompleteResults;
  List<User> items;

  factory UserSearchApiModel.fromJson(Map<String, dynamic> json) {
    List<User> items = [];
    List<dynamic> jsonItems = json['items'];
    jsonItems.forEach((obj) {
      items.add(User.fromJson(obj));
    });

    int totalCount = json['total_count'];
    bool results = json['incomplete_results'];

    UserSearchApiModel result = UserSearchApiModel()
      ..totalCount = totalCount
      ..incompleteResults = results
      ..items = items;

    return result;
  }
}
