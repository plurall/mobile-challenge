import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/modules/users/users_module.dart';
import 'package:mobile_challenge/app/shared/utils/routes.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [$AppController];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute(Routes.USERS, module: UsersModule())
  ];
}
