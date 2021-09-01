import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/data/datasources/database.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/data/providers/search.dart';
import 'package:mobile_challenge/data/repositories/search_remote.dart';
import 'package:mobile_challenge/domain/usecases/get_user/get_user_usecase.dart';
import 'package:mobile_challenge/domain/usecases/search_users/search_users_usecase.dart';
import 'package:mobile_challenge/presentation/view_models/search_view_model.dart';
import 'package:mobile_challenge/presentation/view_models/user_profile_view_model.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';
import 'package:mobile_challenge/presentation/views/home.dart';
import 'package:mobile_challenge/presentation/views/user_profile.dart';
import 'package:provider/provider.dart';

void setupLocator() {
  GetIt locator = GetIt.instance;

  locator.registerLazySingleton(() => Database());
  locator.registerLazySingleton((() => SearchRemoteRepository()));

  locator.registerFactory(
      () => GetUserUseCase(locator.get<SearchRemoteRepository>()));
  locator.registerFactory(
      () => UserProfileViewModel(locator.get<GetUserUseCase>()));

  locator.registerFactory(
      () => SearchUsersUseCase(locator.get<SearchRemoteRepository>()));
  locator.registerFactory(
      () => SearchViewModel(locator.get<SearchUsersUseCase>()));
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
