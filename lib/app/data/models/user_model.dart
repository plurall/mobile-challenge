class UserModel {
  UserModel({
    this.login,
    this.avatarUrl,
    this.location,
    this.bio,
    this.name,
    this.email,
  });

  String login;
  String avatarUrl;
  String location;
  String bio;
  String name;
  String email;

  UserModel.fromJson(Map<String, dynamic> json) {
    this.login = json['login'];
    this.avatarUrl = json['avatar_url'];
    this.location = json['location'];
    this.bio = json['bio'];
    this.name = json['name'];
    this.email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['avatar_url'] = this.avatarUrl;
    data['location'] = this.location;
    data['bio'] = this.bio;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
