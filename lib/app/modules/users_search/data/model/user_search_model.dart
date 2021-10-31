import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String login,
    required int id,
    required String nodeId,
    required String avatarUrl,
    required String gravatarUrl,
    required String url,
    required String htmlUrl,
    required String followersUrl,
    required String followingUrl,
    required String gistsUrl,
    required String starredUrl,
    required String subscriptionsUrl,
    required String organizationsUrl,
    required String reposUrl,
    required String eventsUrl,
    required String receivedEventsUrl,
    required String type,
    required bool siteAdmin,
    required String name,
    required String company,
    required String blog,
    required String location,
    required String email,
    required String hireable,
    required String bio,
    required String twitterUsername,
    required int publicRepos,
    required int publicGists,
    required int followers,
    required int following,
    required String createdAt,
    required String updatedAt,
  }) : super(
          login: login,
          id: id,
          nodeId: nodeId,
          avatarUrl: avatarUrl,
          gravatarUrl: gravatarUrl,
          url: url,
          htmlUrl: htmlUrl,
          followersUrl: followersUrl,
          followingUrl: followingUrl,
          gistsUrl: gistsUrl,
          starredUrl: starredUrl,
          subscriptionsUrl: subscriptionsUrl,
          organizationsUrl: organizationsUrl,
          reposUrl: reposUrl,
          eventsUrl: eventsUrl,
          receivedEventsUrl: receivedEventsUrl,
          type: type,
          siteAdmin: siteAdmin,
          name: name,
          company: company,
          blog: blog,
          location: location,
          email: email,
          hireable: hireable,
          bio: bio,
          twitterUsername: twitterUsername,
          publicRepos: publicRepos,
          publicGists: publicGists,
          followers: followers,
          following: following,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        login: json['login'],
        id: json['id'],
        nodeId: json['nodeId'],
        avatarUrl: json['avatarUrl'],
        gravatarUrl: json['gravatarUrl'],
        url: json['url'],
        htmlUrl: json['htmlUrl'],
        followersUrl: json['followersUrl'],
        followingUrl: json['followingUrl'],
        gistsUrl: json['gistsUrl'],
        starredUrl: json['starredUrl'],
        subscriptionsUrl: json['subscriptionsUrl'],
        organizationsUrl: json['organizationsUrl'],
        reposUrl: json['reposUrl'],
        eventsUrl: json['eventsUrl'],
        receivedEventsUrl: json['receivedEventsUrl'],
        type: json['type'],
        siteAdmin: json['siteAdmin'],
        name: json['name'],
        company: json['company'],
        blog: json['blog'],
        location: json['location'],
        email: json['email'],
        hireable: json['hireable'],
        bio: json['bio'],
        twitterUsername: json['twitterUsername'],
        publicRepos: json['publicRepos'],
        publicGists: json['publicGists'],
        followers: json['followers'],
        following: json['following'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['nodeId'] = this.nodeId;
    data['avatarUrl'] = this.avatarUrl;
    data['gravatarUrl'] = this.gravatarUrl;
    data['url'] = this.url;
    data['htmlUrl'] = this.htmlUrl;
    data['followersUrl'] = this.followersUrl;
    data['followingUrl'] = this.followingUrl;
    data['gistsUrl'] = this.gistsUrl;
    data['starredUrl'] = this.starredUrl;
    data['subscriptionsUrl'] = this.subscriptionsUrl;
    data['organizationsUrl'] = this.organizationsUrl;
    data['reposUrl'] = this.reposUrl;
    data['eventsUrl'] = this.eventsUrl;
    data['receivedEventsUrl'] = this.receivedEventsUrl;
    data['type'] = this.type;
    data['siteAdmin'] = this.siteAdmin;
    data['name'] = this.name;
    data['company'] = this.company;
    data['blog'] = this.blog;
    data['location'] = this.location;
    data['email'] = this.email;
    data['hireable'] = this.hireable;
    data['bio'] = this.bio;
    data['twitterUsername'] = this.twitterUsername;
    data['publicRepos'] = this.publicRepos;
    data['publicGists'] = this.publicGists;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
