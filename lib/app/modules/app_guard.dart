import 'package:flutter_modular/flutter_modular.dart';

import '../app_module.dart';

class AppGuard extends RouteGuard {
  AppGuard(String? guardedRoute) : super(guardedRoute);
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    await Modular.isModuleReady<AppModule>();
    return true;
  }
}