import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:mobile_challenge/app/modules/search/data/remote_search_user_datasource.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_user.dart';
import 'package:mobile_challenge/app/modules/search/infra/repositories/search_user_repository_impl.dart';

import 'modules/search/ui/search_page.dart';


class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Client()),
    Bind((i) => RemoteSearchUserDataSource(i())),
    Bind((i) => SearchUserRepositoryImpl(i())),
    Bind((i) => SearchUserImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SearchPage()),
  ];

}