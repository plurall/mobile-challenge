import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';

class DetailUserModel extends UserDetailEntity {
  DetailUserModel({
    required String image,
    String? location,
    String? bio,
    required String nickname,
    String? email,
  }) : super(
          image: image,
          location: location,
          bio: bio,
          nickname: nickname,
          email: email,
        );

  factory DetailUserModel.fromJson(Map<String, dynamic> json) =>
      DetailUserModel(
        image: json['image'],
        location: json['location'],
        bio: json['bio'],
        nickname: json['nickname'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['location'] = this.location;
    data['bio'] = this.bio;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    return data;
  }
}
