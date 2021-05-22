import 'package:mobile_challenge/modules/user_list/domain/entities/User.dart';

class UserSearchModel {
  UserSearchModel();

  int totalCount;
  bool incompleteResults;
  List<User> items;

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    List<User> items = [];
    List<dynamic> jsonItems = json['items'];
    jsonItems.forEach((obj) {
      items.add(User.fromJson(obj));
    });

    int totalCount = json['total_count'];
    bool results = json['incomplete_results'];

    UserSearchModel result = UserSearchModel()
      ..totalCount = totalCount
      ..incompleteResults = results
      ..items = items;

    return result;
  }
}
