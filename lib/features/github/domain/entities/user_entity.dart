import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  int id;
  String login;
  String avatarUrl;
  String name;
  String email;
  String bio;
  String location;

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
