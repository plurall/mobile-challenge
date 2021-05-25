import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/github/data/remote/data_sources/github_search_data_source.dart';
import 'package:mobile_challenge/app/github/data/repositories/github_search_respository_impl.dart';
import 'package:mobile_challenge/app/github/domain/use_cases/github_search_by_user_name.dart';
import 'package:mobile_challenge/app/github/presentation/pages/details_user_page.dart';
import 'package:mobile_challenge/app/github/presentation/pages/start_page.dart';
import 'package:mobile_challenge/app/github/presentation/search_bloc.dart';

import 'presentation/search_user_bloc.dart';

class GitHubModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => GitHubDataSource(i())),
    Bind((i) => GitHubSearchRepositoryImpl(i())),
    Bind((i) => GitHubSearchByUserNameImpl(i())),
    Bind((i) => SearchBloc(i())),
    Bind((i) => SearchUserBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => StartPage()),
    ChildRoute(
      '/details',
      child: (_, args) => DetailsUserPage(
        userName: args.data,
      ),
    ),
  ];
}
