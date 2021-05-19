import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  int id;
  String login;
  String name;
  String email;
  String avatarUrl;
  String bio;
  String location;

  UserEntity({
    @required this.id,
    @required this.login,
    @required this.name,
    @required this.email,
    @required this.avatarUrl,
    @required this.bio,
    @required this.location,
  });

  @override
  List<Object> get props => [id, login, name, email, avatarUrl, bio, location];
}
