import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/data/providers/search.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';
import 'package:mobile_challenge/presentation/views/home.dart';
import 'package:mobile_challenge/presentation/views/user_profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteUsersProvider(),
        ),
        Provider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Github API',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'RobotoCondensed',
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          HomeView.routeName: (context) => HomeView(),
          FavoritesView.routeName: (context) => FavoritesView(),
          SearchView.routeName: (context) => SearchView(),
          UserProfileView.routeName: (context) => UserProfileView(),
        },
      ),
    );
  }
}
