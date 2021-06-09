import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserEntity extends Equatable {
  final int id;
  final String avatarUrl;
  final String login;

  UserEntity(
      {@required this.avatarUrl, @required this.login, @required this.id});

  @override
  List<Object> get props => [this.id, this.avatarUrl, this.login];
}
