import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/favorites/data/repositories/get_favorites.repository.impl.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/usecases/get_favorites.usecase.impl.dart';
import 'package:mobile_challenge/app/modules/favorites/external/get_favorites.datasource.impl.dart';
import 'package:mobile_challenge/app/modules/favorites/presentation/controllers/favorites_controller.dart';
import 'package:mobile_challenge/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:mobile_challenge/app/modules/users/data/repositories/get_search_users.repository.impl.dart';
import 'package:mobile_challenge/app/modules/users/data/repositories/get_users.repository.impl.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_search_users.usecase.impl.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.impl.dart';
import 'package:mobile_challenge/app/modules/users/external/get_search_users.datasource.impl.dart';
import 'package:mobile_challenge/app/modules/users/external/get_users.datasource.impl.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mobile_challenge/app/shared/helper/db_helper.dart';
import 'package:mobile_challenge/app/shared/utils/constants.dart';
import 'package:dio/dio.dart';

import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
    $UsersController,
    $FavoritesController,
    Bind((i) => Dio(BaseOptions(baseUrl: Constants.ENDPOINT))),
    Bind((i) => GetUsersUsecaseImpl(GetUsersRepositoryImpl(i.get()))),
    Bind((i) => GetUsersDatasourceImpl(i.get())),
    Bind((i) =>
        GetSearchUsersUsecaseImpl(GetSearchUsersRepositoryImpl(i.get()))),
    Bind((i) => GetSearchUsersDatasourceImpl(i.get())),
    Bind((i) => DatabaseHelp()),
    Bind((i) => GetFavoritesUsecaseImpl(GetFavoritesRepositoryImpl(i.get()))),
    Bind((i) => GetFavoritesDatasourceImpl(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
