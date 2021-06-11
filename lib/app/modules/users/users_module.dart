import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/core/shared/helper/db_helper.dart';
import 'package:mobile_challenge/app/core/utils/constants.dart';
import 'package:mobile_challenge/app/core/utils/routes.dart';
import 'package:mobile_challenge/app/modules/users/data/repositories/get_search_users.repository.impl.dart';
import 'package:mobile_challenge/app/modules/users/data/repositories/get_users.repository.impl.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_search_users.usecase.impl.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.impl.dart';
import 'package:mobile_challenge/app/modules/users/external/get_search_users.datasource.impl.dart';
import 'package:mobile_challenge/app/modules/users/external/get_users.datasource.impl.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/user_detail_controller.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mobile_challenge/app/modules/users/presentation/pages/user_detail.page.dart';
import 'package:mobile_challenge/app/modules/users/presentation/pages/users.page.dart';
import 'package:dio/dio.dart';

import 'data/repositories/do_favorite_user.repository.impl.dart';
import 'data/repositories/get_user.repository.impl.dart';
import 'data/repositories/remove_favorite_user.repository.impl.dart';
import 'domain/usecases/do_favorite_user.usecase.impl.dart';
import 'domain/usecases/get_user.usecase.impl.dart';
import 'domain/usecases/remove_favorite_user.usecase.impl.dart';
import 'external/do_favorite_user.datasource.impl.dart';
import 'external/get_user.datasource.impl.dart';
import 'external/remove_favorite_user.datasource.impl.dart';

class UsersModule extends Module {
  @override
  final List<Bind> binds = [
    $UsersController,
    $UserDetailController,
    Bind((i) => Dio(BaseOptions(baseUrl: Constants.ENDPOINT))),
    Bind((i) => GetUserUsecaseImpl(GetUserRepositoryImpl(i.get()))),
    Bind((i) => GetUserDatasourceImpl(i.get())),
    Bind((i) => GetUsersUsecaseImpl(GetUsersRepositoryImpl(i.get()))),
    Bind((i) => GetUsersDatasourceImpl(i.get())),
    Bind((i) =>
        GetSearchUsersUsecaseImpl(GetSearchUsersRepositoryImpl(i.get()))),
    Bind((i) => GetSearchUsersDatasourceImpl(i.get())),
    Bind((i) => DatabaseHelp()),
    Bind((i) =>
        DoFavoriteUserUsecaseImpl(DoFavoriteUserRepositoryImpl(i.get()))),
    Bind((i) => DoFavoriteUserDatasourceImpl(i.get())),
    Bind((i) => RemoveFavoriteUserUsecaseImpl(
        RemoveFavoriteUserRepositoryImpl(i.get()))),
    Bind((i) => RemoveFavoriteUserDatasourceImpl(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => UsersPage()),
    ChildRoute(Routes.DETAIL, child: (_, args) => UserDetailPage()),
  ];
}
