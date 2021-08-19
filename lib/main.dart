import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';
import 'package:mobile_challenge/presentation/views/home.dart';
import 'package:mobile_challenge/presentation/views/user_profile.dart';
import 'package:mobile_challenge/utils/app_routes.dart';
import 'package:mobile_challenge/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final List<UserSummary> favoriteUsers = [];

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    updateFavorites(UserSummary user) {
      final isFavoriteUser = Utils.isFavoriteUser(widget.favoriteUsers, user);
      setState(
        () => {
          if (isFavoriteUser)
            {widget.favoriteUsers.remove(user)}
          else
            {widget.favoriteUsers.add(user)}
        },
      );
    }

    return MaterialApp(
      title: 'Github API',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'RobotoCondensed',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.Home: (context) => HomeView(widget.favoriteUsers),
        AppRoutes.Favorites: (context) => FavoritesView(widget.favoriteUsers),
        AppRoutes.Search: (context) => SearchView(),
        AppRoutes.UserProfile: (context) =>
            UserProfileView(widget.favoriteUsers, updateFavorites),
      },
    );
  }
}
