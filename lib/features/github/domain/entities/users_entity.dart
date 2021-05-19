import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

class UsersEntity extends Equatable {
  final List<UserEntity> users;

  UsersEntity({@required this.users});

  @override
  List<Object> get props => [users];
}
