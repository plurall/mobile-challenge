class Users {
  String _login;
  int _id;
  String _nodeId;
  String _avatarUrl;
  String _gravatarId;
  String _url;
  String _htmlUrl;
  String _followersUrl;
  String _followingUrl;
  String _gistsUrl;
  String _starredUrl;
  String _subscriptionsUrl;
  String _organizationsUrl;
  String _reposUrl;
  String _eventsUrl;
  String _receivedEventsUrl;
  String _type;
  bool _siteAdmin;

  Users(
      {String login,
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
      bool siteAdmin}) {
    this._login = login;
    this._id = id;
    this._nodeId = nodeId;
    this._avatarUrl = avatarUrl;
    this._gravatarId = gravatarId;
    this._url = url;
    this._htmlUrl = htmlUrl;
    this._followersUrl = followersUrl;
    this._followingUrl = followingUrl;
    this._gistsUrl = gistsUrl;
    this._starredUrl = starredUrl;
    this._subscriptionsUrl = subscriptionsUrl;
    this._organizationsUrl = organizationsUrl;
    this._reposUrl = reposUrl;
    this._eventsUrl = eventsUrl;
    this._receivedEventsUrl = receivedEventsUrl;
    this._type = type;
    this._siteAdmin = siteAdmin;
  }

  String get login => _login;
  set login(String login) => _login = login;
  int get id => _id;
  set id(int id) => _id = id;
  String get nodeId => _nodeId;
  set nodeId(String nodeId) => _nodeId = nodeId;
  String get avatarUrl => _avatarUrl;
  set avatarUrl(String avatarUrl) => _avatarUrl = avatarUrl;
  String get gravatarId => _gravatarId;
  set gravatarId(String gravatarId) => _gravatarId = gravatarId;
  String get url => _url;
  set url(String url) => _url = url;
  String get htmlUrl => _htmlUrl;
  set htmlUrl(String htmlUrl) => _htmlUrl = htmlUrl;
  String get followersUrl => _followersUrl;
  set followersUrl(String followersUrl) => _followersUrl = followersUrl;
  String get followingUrl => _followingUrl;
  set followingUrl(String followingUrl) => _followingUrl = followingUrl;
  String get gistsUrl => _gistsUrl;
  set gistsUrl(String gistsUrl) => _gistsUrl = gistsUrl;
  String get starredUrl => _starredUrl;
  set starredUrl(String starredUrl) => _starredUrl = starredUrl;
  String get subscriptionsUrl => _subscriptionsUrl;
  set subscriptionsUrl(String subscriptionsUrl) =>
      _subscriptionsUrl = subscriptionsUrl;
  String get organizationsUrl => _organizationsUrl;
  set organizationsUrl(String organizationsUrl) =>
      _organizationsUrl = organizationsUrl;
  String get reposUrl => _reposUrl;
  set reposUrl(String reposUrl) => _reposUrl = reposUrl;
  String get eventsUrl => _eventsUrl;
  set eventsUrl(String eventsUrl) => _eventsUrl = eventsUrl;
  String get receivedEventsUrl => _receivedEventsUrl;
  set receivedEventsUrl(String receivedEventsUrl) =>
      _receivedEventsUrl = receivedEventsUrl;
  String get type => _type;
  set type(String type) => _type = type;
  bool get siteAdmin => _siteAdmin;
  set siteAdmin(bool siteAdmin) => _siteAdmin = siteAdmin;

  Users.fromJson(Map<String, dynamic> json) {
    _login = json['login'];
    _id = json['id'];
    _nodeId = json['node_id'];
    _avatarUrl = json['avatar_url'];
    _gravatarId = json['gravatar_id'];
    _url = json['url'];
    _htmlUrl = json['html_url'];
    _followersUrl = json['followers_url'];
    _followingUrl = json['following_url'];
    _gistsUrl = json['gists_url'];
    _starredUrl = json['starred_url'];
    _subscriptionsUrl = json['subscriptions_url'];
    _organizationsUrl = json['organizations_url'];
    _reposUrl = json['repos_url'];
    _eventsUrl = json['events_url'];
    _receivedEventsUrl = json['received_events_url'];
    _type = json['type'];
    _siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this._login;
    data['id'] = this._id;
    data['node_id'] = this._nodeId;
    data['avatar_url'] = this._avatarUrl;
    data['gravatar_id'] = this._gravatarId;
    data['url'] = this._url;
    data['html_url'] = this._htmlUrl;
    data['followers_url'] = this._followersUrl;
    data['following_url'] = this._followingUrl;
    data['gists_url'] = this._gistsUrl;
    data['starred_url'] = this._starredUrl;
    data['subscriptions_url'] = this._subscriptionsUrl;
    data['organizations_url'] = this._organizationsUrl;
    data['repos_url'] = this._reposUrl;
    data['events_url'] = this._eventsUrl;
    data['received_events_url'] = this._receivedEventsUrl;
    data['type'] = this._type;
    data['site_admin'] = this._siteAdmin;
    return data;
  }
}