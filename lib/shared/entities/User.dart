class User {
  User();

  String nickname = '';
  String profilePhoto = '';
  String name = '';
  String location = '';
  String bio = '';
  String email = '';

  factory User.fromJson(Map<String, dynamic> json) {
    User result = User()
      ..nickname = json['login']
      ..profilePhoto = json['avatar_url'];

    return result;
  }
}
