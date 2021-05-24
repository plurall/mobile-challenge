import 'package:flutter/material.dart';

@immutable
abstract class FavoritesEvent {
  @override
  List<Object> get props => [];
}

class GetFavoritesEvent extends FavoritesEvent {}

class GetDefaultUserListEvent extends FavoritesEvent {}
