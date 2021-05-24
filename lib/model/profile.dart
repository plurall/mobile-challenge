class Profile {
  String? nickname;
  String? avatarUrl;
  String? location;
  String? bio;
  String? email;
  String login;
  bool favorite = false;

  Profile(
      {required this.login,
      this.nickname,
      this.location,
      this.bio,
      this.email,
      this.avatarUrl});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        nickname: json['nickname'],
        email: json['email'],
        login: json['login'],
        bio: json['bio'],
        location: json['location'],
        avatarUrl: json['avatar_url']);
  }

  Map<String, dynamic> toMap() => {
        'nickname': nickname,
        'location': location,
        'bio': bio,
        'email': email,
        'login': login,
        'avatarUrl': avatarUrl,
      };
  @override
  String toString() {
    return 'Profile: \nLogin: $login\nEmail: $email\nAvatar_url:$avatarUrl\nNickname: $nickname,\nLocation: $location\nBio: $bio\n';
  }
}
