class UserModel {
  UserModel({
    this.login,
    this.id,
    this.avatarUrl,
    this.location,
    this.email,
    this.bio,
  });

  String login;
  int id;
  String avatarUrl;
  String email;
  String location;
  dynamic bio;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        login: json["login"] != null ? json["login"] : "",
        id: json["id"] != null ? json["id"] : "",
        avatarUrl: json["avatar_url"] != null ? json["avatar_url"] : "",
        location: json["location"] != null ? json["location"] : "Couldn't find user location.",
        email: json["email"] != null ? json["email"] : "Couldn't find user e-mail.",
        bio: json["bio"] != null ? json["bio"] : "Couldn't find user bio.",
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "location": location,
        "email": email,
        "bio": bio,
      };
}
