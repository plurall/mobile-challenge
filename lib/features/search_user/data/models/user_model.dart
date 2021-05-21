import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String nickname,
    required String image,
  }) : super(
          nickname: nickname,
          image: image,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nickname: json['nickname'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'image': image,
      };
}
