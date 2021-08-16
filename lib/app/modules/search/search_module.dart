import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/search/ui/search_page.dart';

import 'data/remote_search_user_datasource.dart';
import 'domain/usecases/search_user.dart';
import 'infra/repositories/search_user_repository_impl.dart';

class SearchModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => RemoteSearchUserDataSource(i())),
    Bind((i) => SearchUserRepositoryImpl(i())),
    Bind((i) => SearchUserImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => SearchPage()),
  ];

}