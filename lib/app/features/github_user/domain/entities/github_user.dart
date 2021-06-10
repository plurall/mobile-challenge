import 'package:equatable/equatable.dart';

class GithubUser extends Equatable {
  final int id;
  final String login;
  final String avatar_url;

  GithubUser({
    this.id,
    this.login,
    this.avatar_url,
  });

  @override
  List<Object> get props => [id, login];
}
