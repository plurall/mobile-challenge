import 'package:get/get.dart';
import 'package:mobile_challenge/app/modules/favorites/favorites_binding.dart';
import 'package:mobile_challenge/app/modules/favorites/favorites_page.dart';
import 'package:mobile_challenge/app/modules/search/search_binding.dart';
import 'package:mobile_challenge/app/modules/search/search_page.dart';
import 'package:mobile_challenge/app/modules/user_info/user_info_binding.dart';
import 'package:mobile_challenge/app/modules/user_info/user_info_page.dart';

class Pages {
  static final routes = [
    GetPage(
      name: SearchPage.route,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: FavoritesPage.route,
      page: () => FavoritesPage(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: UserInfoPage.route,
      page: () => UserInfoPage(),
      binding: UserInfoBinding(),
    ),
  ];
}
