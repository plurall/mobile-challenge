import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';

class UsersEntity extends Equatable {
  List<UserEntity> users;

  UsersEntity({this.users});

  @override
  List<Object> get props => [users];
}
