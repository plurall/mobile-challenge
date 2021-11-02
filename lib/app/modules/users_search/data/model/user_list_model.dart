import 'package:mobile_challenge/app/modules/users_search/data/model/user_search_model.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_list_entity.dart';

class UserListModel extends UserListEntity {
  UserListModel({
    List<UserModel>? userListEntity,
  }) : super(userListEntity: userListEntity);

  UserListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      userListEntity = <UserModel>[];
      json['items'].forEach((v) {
        userListEntity!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] =
        this.userListEntity!.map((v) => (v as UserModel).toJson()).toList();
    return data;
  }
}
