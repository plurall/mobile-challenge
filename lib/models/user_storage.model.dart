class UserStorageModel {
  UserStorageModel({
    this.login,
    this.location,
    this.bio,
    this.email,
  });

  UserStorageModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    location = json['location'];
    bio = json['bio'];
    email = json['email'];
  }

  String login;
  String location;
  String bio;
  String email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['login'] = login;
    data['location'] = location;
    data['bio'] = bio;
    data['email'] = email;

    return data;
  }
}
