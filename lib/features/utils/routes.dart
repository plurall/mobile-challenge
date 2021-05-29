import 'package:flutter/material.dart';

import '../../ui/pages/pages.dart';

abstract class Routes {
  static const String INITIAL_ROUTE = '/';
  static const String HOME = '/';
  static const String FAVORITE_PAGE = '/favorites';
  static const String PROFILE_PAGE = '/details';
  static const String PROFILE_PAGE_FROM_DATABASE = '/detailsFromDatabase';
  static Map<String, Widget Function(BuildContext)> pages = {
    Routes.HOME: (context) => HomePage(),
    Routes.FAVORITE_PAGE: (context) => FavoritesPage(),
    Routes.PROFILE_PAGE: (context) => Profile(),
    Routes.PROFILE_PAGE_FROM_DATABASE: (context) => Profile(
          isFromDatabase: true,
        ),
  };
}
