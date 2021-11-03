class User {
  User({
    this.login,
    this.id,
    this.avatarUrl,
    this.location,
    this.email,
    this.bio,
  });

  final String login;
  final int id;
  final String avatarUrl;
  final String email;
  final String location;
  final dynamic bio;


  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "location": location,
        "email": email,
        "bio": bio,
      };
}