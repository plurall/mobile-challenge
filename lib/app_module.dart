import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/features/search_user/presenter/details_user_page.dart';
import 'package:mobile_challenge/features/search_user/presenter/search_user_store.dart';

import 'features/search_user/data/datasource/search_user_datasource_impl.dart';
import 'features/search_user/data/repositories/search_user_repository_impl.dart';
import 'features/search_user/domain/usecases/search_user_by_text.dart';
import 'features/search_user/presenter/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SearchUserStore(i())),
    Bind((i) => SearchUserByText(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchUserDatasourceImpl(i())),
    Bind((i) => Dio()),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/details_user', child: (_, __) => DetailsUserPage()),
  ];
}
