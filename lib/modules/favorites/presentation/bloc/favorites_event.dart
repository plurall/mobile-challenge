import 'package:flutter/material.dart';

@immutable
abstract class FavoritesEvent {}

class GetFavoritesEvent extends FavoritesEvent {}

class GetDefaultUserListEvent extends FavoritesEvent {}
