import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/app_theme.dart';

import 'core/pages/splash_page.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (_, args) => SplashPage()),
    ChildRoute("/home", child: (_, args) => Material(
      child: Container(
        color: AppTheme.appColor,
        child: Center(
          child: Text("Bazinga!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: "Raleway"
            ),
          ),
        ),
      ),
    )),
  ];
}