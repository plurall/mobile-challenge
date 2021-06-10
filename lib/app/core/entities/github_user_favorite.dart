import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GithubUserFavorite extends Equatable {
  final String name;
  final String email;
  final String location;
  final String bio;
  final String avatar_url;

  GithubUserFavorite({
    @required this.name,
    @required this.email,
    @required this.location,
    @required this.bio,
    @required this.avatar_url,
  });

  @override
  List<Object> get props => [name, email, location, bio];
}
