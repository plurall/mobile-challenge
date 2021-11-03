import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/services/app_service.dart';
import 'package:mobile_challenge/services/dio_http_service.dart';
import 'package:mobile_challenge/views/pages/home_page.dart';

import 'repositories/user_repository.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => AppService()),
        Bind.singleton((i) => DioService()),
        Bind.lazySingleton((i) => UserRepository(Modular.get<DioService>()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage()),
      ];
}
