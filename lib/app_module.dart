import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/home_module.dart';

import 'modules/search/domain/usercases/search_by_text.dart';
import 'modules/search/external/datasources/githud_datasource.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';
import 'modules/search/presenter/search/search_bloc.dart';



class AppModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Dio()),
    Bind.singleton((i) => GitHubDataSource(i())),
    Bind.singleton((i) => SearchRepositoryImp(i())),
    Bind.singleton((i) => SearchByTexteImpl(i())),
    Bind.singleton((i) => SearchBloc(i())),
  ];


  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
  ];

}