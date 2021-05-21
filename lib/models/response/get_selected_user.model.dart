class GetSelectedUserModel {
  GetSelectedUserModel({
    this.avatar_url,
    this.login,
    this.location,
    this.bio,
    this.email,
  });

  GetSelectedUserModel.fromJson(Map<String, dynamic> json) {
    avatar_url = json['avatar_url'];
    login = json['login'];
    location = json['location'];
    bio = json['bio'];
    email = json['email'];
  }

  String avatar_url;
  String login;
  String location;
  String bio;
  String email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_url'] = avatar_url;
    data['login'] = login;
    data['location'] = location;
    data['bio'] = bio;
    data['email'] = email;

    return data;
  }
}
