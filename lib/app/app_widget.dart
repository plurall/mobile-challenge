import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/common/constants/app_routes.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/pages/user_detail_page.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/pages/user_search_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User search',
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.USER_SEARCH: (ctx) => UserSearchPage(),
        AppRoutes.USER_DETAIL: (ctx) => UserDetailPage(),
      },
    );
  }
}
