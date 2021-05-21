class GetUsersGitModel {
  GetUsersGitModel({
    this.avatar_url,
    this.login,
  });

  GetUsersGitModel.fromJson(Map<String, dynamic> json) {
    avatar_url = json['avatar_url'];
    login = json['login'];
  }

  String avatar_url;
  String login;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_url'] = avatar_url;
    data['login'] = login;

    return data;
  }
}
