import 'package:flutter/material.dart';
import 'package:github_api/views/favorites.dart';
import 'package:github_api/views/homepage.dart';
import 'package:github_api/views/profileGithub.dart';

abstract class Routes {
  static const String INITIAL_ROUTE = '/';
  static const String HOME = '/';
  static const String FAVORITE_PAGE = '/favorites';
  static const String PROFILE_PAGE = '/details';
  static const String PROFILE_PAGE_FROM_DATABASE = '/detailsFromDatabase';
  static Map<String, Widget Function(BuildContext)> pages = {
    Routes.HOME: (context) => HomePage(),
    Routes.FAVORITE_PAGE: (context) => FavoritesPage(),
    Routes.PROFILE_PAGE: (context) => ProfileGithub(),
    Routes.PROFILE_PAGE_FROM_DATABASE: (context) => ProfileGithub(
          isFromDatabase: true,
        ),
  };
}
