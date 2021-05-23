class User {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;
  String name;
  String company;
  String blog;
  String location;
  String email;
  bool hireable;
  String bio;
  String twitterUsername;
  int publicRepos;
  int publicGists;
  int followers;
  int following;
  String createdAt;
  String updatedAt;

  User({
    String login,
    int id,
    String nodeId,
    String avatarUrl,
    String gravatarId,
    String url,
    String htmlUrl,
    String followersUrl,
    String followingUrl,
    String gistsUrl,
    String starredUrl,
    String subscriptionsUrl,
    String organizationsUrl,
    String reposUrl,
    String eventsUrl,
    String receivedEventsUrl,
    String type,
    bool siteAdmin,
    String name,
    String company,
    String blog,
    String location,
    String email,
    bool hireable,
    String bio,
    String twitterUsername,
    int publicRepos,
    int publicGists,
    int followers,
    int following,
    String createdAt,
    String updatedAt,
  }) {
    this.login = login;
    this.id = id;
    this.nodeId = nodeId;
    this.avatarUrl = avatarUrl;
    this.gravatarId = gravatarId;
    this.url = url;
    this.htmlUrl = htmlUrl;
    this.followersUrl = followersUrl;
    this.followingUrl = followingUrl;
    this.gistsUrl = gistsUrl;
    this.starredUrl = starredUrl;
    this.subscriptionsUrl = subscriptionsUrl;
    this.organizationsUrl = organizationsUrl;
    this.reposUrl = reposUrl;
    this.eventsUrl = eventsUrl;
    this.receivedEventsUrl = receivedEventsUrl;
    this.type = type;
    this.siteAdmin = siteAdmin;
    this.name = name;
    this.company = company;
    this.blog = blog;
    this.location = location;
    this.email = email;
    this.hireable = hireable;
    this.bio = bio;
    this.twitterUsername = twitterUsername;
    this.publicRepos = publicRepos;
    this.publicGists = publicGists;
    this.followers = followers;
    this.following = following;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
    name = json['name'];
    company = json['company'];
    blog = json['blog'];
    location = json['location'];
    email = json['email'];
    hireable = json['hireable'];
    bio = json['bio'];
    twitterUsername = json['twitter_username'];
    publicRepos = json['public_repos'];
    publicGists = json['public_gists'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['node_id'] = this.nodeId;
    data['avatar_url'] = this.avatarUrl;
    data['gravatar_id'] = this.gravatarId;
    data['url'] = this.url;
    data['html_url'] = this.htmlUrl;
    data['followers_url'] = this.followersUrl;
    data['following_url'] = this.followingUrl;
    data['gists_url'] = this.gistsUrl;
    data['starred_url'] = this.starredUrl;
    data['subscriptions_url'] = this.subscriptionsUrl;
    data['organizations_url'] = this.organizationsUrl;
    data['repos_url'] = this.reposUrl;
    data['events_url'] = this.eventsUrl;
    data['received_events_url'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['site_admin'] = this.siteAdmin;
    data['name'] = this.name;
    data['company'] = this.company;
    data['blog'] = this.blog;
    data['location'] = this.location;
    data['email'] = this.email;
    data['hireable'] = this.hireable;
    data['bio'] = this.bio;
    data['twitter_username'] = this.twitterUsername;
    data['public_repos'] = this.publicRepos;
    data['public_gists'] = this.publicGists;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
