import 'package:flutter/material.dart';

@immutable
abstract class UserDetailEvent {
  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserDetailEvent {
  final String nickname;

  GetUserEvent(this.nickname);

  @override
  List<Object> get props => [nickname];
}
