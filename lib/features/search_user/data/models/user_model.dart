class UserModel {
  late String image;
  late String nickname;

  UserModel({
    required this.image,
    required this.nickname,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['nickname'] = this.nickname;
    return data;
  }
}
