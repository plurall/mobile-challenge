import 'package:flutter_modular/flutter_modular.dart';

import 'modules/search/search_page.dart';


class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SearchPage()),
  ];

}