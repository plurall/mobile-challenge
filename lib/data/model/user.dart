class User {
  final int id;
  final String? name;
  final String login;
  final String avatar;
  final String? location;
  final String? email;
  final String? bio;

  User({
    required this.name,
    required this.id,
    required this.login,
    required this.bio,
    required this.avatar,
    required this.email,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      login: json['login'],
      bio: json['bio'],
      avatar: json['avatar_url'],
      email: json['email'],
      location: json['location'],
    );
  }
}

/*
{
  "login": "williambraz",
  "id": 1655785,
  "node_id": "MDQ6VXNlcjE2NTU3ODU=",
  "avatar_url": "https://avatars.githubusercontent.com/u/1655785?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/williambraz",
  "html_url": "https://github.com/williambraz",
  "followers_url": "https://api.github.com/users/williambraz/followers",
  "following_url": "https://api.github.com/users/williambraz/following{/other_user}",
  "gists_url": "https://api.github.com/users/williambraz/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/williambraz/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/williambraz/subscriptions",
  "organizations_url": "https://api.github.com/users/williambraz/orgs",
  "repos_url": "https://api.github.com/users/williambraz/repos",
  "events_url": "https://api.github.com/users/williambraz/events{/privacy}",
  "received_events_url": "https://api.github.com/users/williambraz/received_events",
  "type": "User",
  "site_admin": false,
  "name": "William Braz",
  "company": null,
  "blog": "",
  "location": null,
  "email": null,
  "hireable": null,
  "bio": null,
  "twitter_username": null,
  "public_repos": 10,
  "public_gists": 0,
  "followers": 2,
  "following": 1,
  "created_at": "2012-04-18T14:26:11Z",
  "updated_at": "2021-05-14T17:01:13Z"
}*/
