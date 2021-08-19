import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:mobile_challenge/app/modules/user/user_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Client()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute("/", module: UserModule()),
  ];

}