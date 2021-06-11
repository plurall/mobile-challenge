import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserEntity extends Equatable {
  final int id;
  final String avatarUrl;
  final String login;
  final String bio;
  final String location;
  final String email;

  UserEntity(
      {@required this.avatarUrl,
      @required this.login,
      @required this.id,
      this.bio,
      this.location,
      this.email});

  @override
  List<Object> get props => [this.id, this.avatarUrl, this.login];
}
