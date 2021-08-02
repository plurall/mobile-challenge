import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app_widget.dart';
import 'package:mobile_challenge/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/modules/search/external/datasources/github_datasource.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_block.dart';
import 'modules/search/domain/usecases/search_perfil_by_text.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';
import 'modules/search/presenter/search/search_page.dart';
import 'modules/search/presenter/search/search_perfil_block.dart';
import 'modules/search/presenter/search/search_perfil_page.dart';

class AppModule extends Module{
  @override
  // TODO: implement binds
  List<Bind> get binds => [
    Bind((i)=>Dio()),
    Bind((i)=>GithubDatasource(i())),
    Bind((i)=>SearchRepositoryImpl(i())),
    Bind((i)=>SearchByTextImpl(i())),
    Bind((i)=>SearchPerfilByTextImpl(i())),
    Bind((i)=>SearchBlock(i())),
    Bind((i)=>SearchPerfilBlock(i())),

  ];

  @override
  // TODO: implement routers
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => SearchPage()),
    ChildRoute('/perfil/:name', child: (_, args) => SearchPerfilPage(name: args.params['name'])),
  ];

  @override
  // TODO: implement bootstrap
  Widget get bootstrap => AppWidget();


}