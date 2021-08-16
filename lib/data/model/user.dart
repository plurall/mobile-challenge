class User {
  final int id;
  final String login;
  final String avatar;

  User({
    required this.id,
    required this.login,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      avatar: json['avatar_url'],
      id: json['id'],
      login: json['login'],
    );
  }

  /*
  id: 1655785, 
  node_id: MDQ6VXNlcjE2NTU3ODU=, 
  avatar_url: https://avatars.githubusercontent.com/u/1655785?v=4, 
  gravatar_id: , 
  url: https://api.github.com/users/williambraz, 
  html_url: https://github.com/williambraz, 
  followers_url: https://api.github.com/users/williambraz/followers, 
  following_url: https://api.github.com/users/williambraz/following{/other_user}, 
  gists_url: https://api.github.com/users/williambraz/gists{/gist_id}, 
  starred_url: https://api.github.com/users/williambraz/starred{/owner}{/repo}, 
  subscriptions_url: https://api.github.com/users/williambraz/subscriptions, 
  organizations_url: https://api.github.com/users/williambraz/orgs, 
  repos_url: https://api.github.com/users/williambraz/repos, 
  events_url: https://api.github.com/users/williambraz/events{/privacy}, 
  received_events_url: https://api.github.com/users/williambraz/received_events, type: User, site_admin: false, score: 1
  */
}
