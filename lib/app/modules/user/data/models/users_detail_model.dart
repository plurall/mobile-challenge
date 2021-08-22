import 'dart:convert';
import 'user_detail_model.dart';


class UsersDetailModel {
  List<UserDetailModel> users;
  UsersDetailModel({
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return {
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory UsersDetailModel.fromMap(Map<String, dynamic> map) {
    return UsersDetailModel(
      users: List<UserDetailModel>.from(map['users'].map((x) => UserDetailModel.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());
}
