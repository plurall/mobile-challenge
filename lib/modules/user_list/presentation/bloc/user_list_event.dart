import 'package:flutter/material.dart';

@immutable
abstract class UserListEvent {}

class GetNewPageUserSearchEvent extends UserListEvent {
  final String query;
  final int page;

  GetNewPageUserSearchEvent(this.query, this.page);
}

class GetUserSearchEvent extends UserListEvent {
  final String query;

  GetUserSearchEvent(this.query);
}

class GetDefaultUserListEvent extends UserListEvent {}
