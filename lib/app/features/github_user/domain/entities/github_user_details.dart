import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GithubUserDetails extends Equatable {
  final int id;
  final String avatar_url;
  final String login;
  final String name;
  final String location;
  final String bio;
  final String email;

  GithubUserDetails({
    @required this.id,
    @required this.avatar_url,
    @required this.login,
    @required this.name,
    @required this.location,
    @required this.bio,
    @required this.email,
  });

  @override
  List<Object> get props => [id, avatar_url, login, name, location, bio, email];
}
