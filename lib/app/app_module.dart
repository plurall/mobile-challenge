import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/core/pages/home.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/modules/search/external/datasources/github_datasource.dart';
import 'package:mobile_challenge/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/usecases/search_by_user_login.dart';
import 'package:mobile_challenge/app/modules/user_search/external/github_user_datasource.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/repositories/user_search_repository_impl.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_details_page.dart';

import 'core/pages/splash_page.dart';
import 'modules/search/presentation/search/search_store.dart';
import 'modules/user_search/presentation/user_search_store.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => GithubDatasource(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => SearchStore(i())),
    Bind((i) => GithubUserDatasource(i())),
    Bind((i) => UserSearchRepositoryImpl(i())),
    Bind((i) => SearchByUserLoginImpl(i())),
    Bind((i) => UserSearchStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (_, args) => SplashPage()),
    ChildRoute("/home", child: (_, args) => Home()),
    ChildRoute("/user-details", child: (_, args) => UserDetails(user: args)),
  ];
}