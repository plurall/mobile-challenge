import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String name;
  final String email;
  final String bio;
  final String location;

  UserEntity({
    @required this.id,
    @required this.login,
    @required this.avatarUrl,
    this.name,
    this.email,
    this.bio,
    this.location,
  });

  @override
  List<Object> get props => [id, login, name, email, avatarUrl, bio, location];
}
