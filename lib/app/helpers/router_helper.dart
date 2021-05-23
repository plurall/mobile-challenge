import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/page/main/main_page.dart';
import 'package:mobile_challenge/app/page/user/user_details_page.dart';

class R {
  static const homePage = '/';
  static const userDetailsPage = '/user-details-page';

  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    bool isUserLogged,
  }) {
    switch (settings.name) {
      case homePage:
        return CupertinoPageRoute(
          settings: const RouteSettings(name: homePage),
          builder: (_) => MainPage(),
        );
      case userDetailsPage:
        final object = settings.arguments as String;
        return _createCurveTweenPageRoute(
          UserDetailsPage(
            login: object,
          ),
          userDetailsPage,
        );
      default:
        return _getNoRouteDefined(settings);
        break;
    }
  }

  static CupertinoPageRoute _getNoRouteDefined(RouteSettings settings) {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }

  static Route _createCurveTweenPageRoute(
    Widget page,
    String nameRoute, {
    bool opaque = true,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: nameRoute),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      opaque: opaque,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (animation.status == AnimationStatus.reverse) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        } else {
          final tween = Tween(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.ease),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        }
      },
    );
  }
}
