import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:meta/meta.dart';

class UsersModel extends UsersEntity {
  final List<UserModel> users;

  UsersModel({@required this.users}) : super(users: users);

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        users: (json['items'] as List)
            ?.map((e) => e == null
                ? null
                : UserModel.fromJson(e as Map<String, dynamic>))
            ?.toList());
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "items": users.map((e) => e.toJson()).toList(),
    };
  }
}
