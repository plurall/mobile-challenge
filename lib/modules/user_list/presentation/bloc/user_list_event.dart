import 'package:flutter/material.dart';

@immutable
abstract class UserListEvent {
  @override
  List<Object> get props => [];
}

class GetUserSearchEvent extends UserListEvent {
  final String query;

  GetUserSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

class GetDefaultUserListEvent extends UserListEvent {}
