import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/data/database/database.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/data/providers/search.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';
import 'package:mobile_challenge/presentation/views/home.dart';
import 'package:mobile_challenge/presentation/views/user_profile.dart';
import 'package:provider/provider.dart';

import 'data/remote/search_remote.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => SearchRemote());
  GetIt.instance.registerLazySingleton(() => Database());
}

void main() {
  setupLocator();
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
        Provider(
          create: (context) => ConnectionProvider(),
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
