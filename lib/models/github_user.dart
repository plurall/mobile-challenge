class GitHubUser {
  int id;
  String login;
  String avatarUrl;
  String name;
  String location;
  String htmlUrl;
  String bio;
  String email;

  GitHubUser({
    this.id,
    this.login,
    this.avatarUrl,
    this.name,
    this.location,
    this.htmlUrl,
    this.bio,
    this.email,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) => GitHubUser(
        id: json['id'],
        login: json['login'],
        avatarUrl: json['avatar_url'],
        name: json['name'],
        location: json['location'],
        htmlUrl: json['html_url'],
        bio: json['bio'],
        email: json['email'],
      );
}
