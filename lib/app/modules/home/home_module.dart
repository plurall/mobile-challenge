import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/users/data/repositories/get_users.repository.impl.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_users.repositoory.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.impl.dart';
import 'package:mobile_challenge/app/modules/users/external/get_users.datasource.impl.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mobile_challenge/app/shared/utils/constants.dart';
import 'home_controller.dart';
import 'package:dio/dio.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
    $UsersController,
    Bind((i) => Dio(BaseOptions(baseUrl: Constants.ENDPOINT))),
    Bind((i) => GetUsersUsecaseImpl(GetUsersRepositoryImpl(i.get()))),
    Bind((i) => GetUsersDatasourceImpl(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
