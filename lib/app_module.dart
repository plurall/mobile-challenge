import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/features/search_user/presenter/details_user_page.dart';

import 'features/search_user/presenter/home_page.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/details_user', child: (_, __) => DetailsUserPage()),
  ];
}
