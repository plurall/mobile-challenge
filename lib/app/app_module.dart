import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_challenge/app/core/network/network_info.dart';
import 'package:mobile_challenge/app/modules/app_guard.dart';
import 'package:mobile_challenge/app/modules/user/user_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Client()),
    Bind((i) => InternetConnectionChecker()),
    Bind((i) => NetworkInfoImpl(i())),
    AsyncBind((i) => SharedPreferences.getInstance()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute("/", module: UserModule(), guards: [AppGuard("/")]),
  ];

}