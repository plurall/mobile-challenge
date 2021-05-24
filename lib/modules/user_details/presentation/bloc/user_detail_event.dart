import 'package:flutter/material.dart';

@immutable
abstract class UserDetailEvent {}

class GetUserEvent extends UserDetailEvent {
  final String nickname;

  GetUserEvent(this.nickname);
}
