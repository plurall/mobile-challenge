import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app_widget.dart';
import 'package:mobile_challenge/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/modules/search/external/datasources/github_datasource.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_block.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';
import 'modules/search/presenter/search/search_page.dart';

class AppModule extends Module{
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i)=>Dio()),
    Bind((i)=>GithubDatasource(i())),
    Bind((i)=>SearchRepositoryImpl(i())),
    Bind((i)=>SearchByTextImpl(i())),
    Bind((i)=>SearchBlock(i())),

  ];

  @override
  // TODO: implement routers
//  List get routers => [
//    //Router('/',child: (_, __) => SearchPage())
//    ChildRoute('/', child: (_, __) => SearchPage()),
//  ];

  List<ModularRoute> get routes => [
    // Simple route using the ChildRoute
    ChildRoute('/', child: (_, __) => SearchPage()),
  ];

  @override
  // TODO: implement bootstrap
  Widget get bootstrap => AppWidget();


}