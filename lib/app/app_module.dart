import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:mobile_challenge/app/modules/app_guard.dart';
import 'package:mobile_challenge/app/modules/user/user_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Client()),
    AsyncBind((i) => SharedPreferences.getInstance()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute("/", module: UserModule(), guards: [AppGuard("/")]),
  ];

}