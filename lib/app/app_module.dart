import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/local_storage_interface.dart';
import 'core/services/local_storage_service.dart';
import 'features/github_user/github_module.dart';
import 'features/github_user_favorite/github_user_favorite_module.dart';
//import 'features/github_user_favorite/github_user_favorite_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //external
    Bind((i) => Dio()),
    Bind((i) => SharedPreferences.getInstance()),
    //internal
    Bind<ILocaStorage>((i) => LocalStorageService(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: GithubUserModule()),
    ModuleRoute('/favorite', module: GithubUserFavoriteModule()),
  ];
}
