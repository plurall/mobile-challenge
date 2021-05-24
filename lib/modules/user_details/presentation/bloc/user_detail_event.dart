import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

@immutable
abstract class UserDetailEvent {}

class GetUserEvent extends UserDetailEvent {
  final String nickname;

  GetUserEvent(this.nickname);
}

class GetToggleFavoriteEvent extends UserDetailEvent {
  final User user;

  GetToggleFavoriteEvent(this.user);
}
