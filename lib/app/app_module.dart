import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/modules/search/external/datasources/github_datasource.dart';
import 'package:mobile_challenge/app/modules/search/infra/repositories/search_repository_impl.dart';

import 'core/pages/splash_page.dart';
import 'modules/search/presentation/search/search_page.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => GithubDatasource(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchByTextImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (_, args) => SplashPage()),
    ChildRoute("/home", child: (_, args) => SearchPage()),
  ];
}