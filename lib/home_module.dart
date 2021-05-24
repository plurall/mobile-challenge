import 'package:flutter_modular/flutter_modular.dart';

import 'modules/search/presenter/views/page_Splash_screen_plurall.dart';
import 'modules/search/presenter/views/page_favoritos.dart';
import 'modules/search/presenter/views/page_perfil.dart';
import 'modules/search/presenter/views/page_splash_screen.dart';
import 'modules/search/presenter/views/search_page.dart';



class HomeModule extends Module {

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => PageSplashScreen()),
    ChildRoute("/PageSplashScreenPlurall", child: (_, args) => PageSplashScreenPlurall()),
    ChildRoute("/SearchPage/", child: (_, args) => SearchPage()),
    ChildRoute("/PagePerfil", child: (_, args) => PagePerfil()),
    ChildRoute("/PageFavoritos", child: (_, args) => PageFavoritos())
  ];

}