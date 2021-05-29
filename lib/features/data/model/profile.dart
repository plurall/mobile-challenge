class Profile {
  String nickname;
  String avatarUrl;
  String location;
  String bio;
  String email;
  String login;
  bool favorite = false;

  Profile(
      {this.login,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['location'] = this.location;
    data['bio'] = this.bio;
    data['email'] = this.email;
    data['login'] = this.login;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
