import 'package:flutter_modular/flutter_modular.dart';

import 'data/local/data_sources/github_user_favorite_local_datasource.dart';
import 'data/remote/data_sources/github_search_data_source.dart';
import 'data/repositories/github_search_respository_impl.dart';
import 'domain/use_cases/get_github_user_details.dart';
import 'domain/use_cases/get_github_user_list.dart';
import 'domain/use_cases/set_github_user_favorite.dart';
import 'presentation/bloc/github_user_details_bloc.dart';
import 'presentation/bloc/github_user_list_bloc.dart';
import 'presentation/bloc/set_github_user_favorite.dart';
import 'presentation/pages/github_user_details_page.dart';
import 'presentation/pages/github_users_search.dart';

class GithubUserModule extends Module {
  @override
  final List<Bind> binds = [
    // data/datasource
    Bind((i) => GithubUserRemoteDataSourceImpl(client: i())),
    Bind((i) => GithubUserLocalDataSourceImpl(shared: i())),
    //data/repository
    Bind((i) => GitHubSearchRepositoryImpl(
        localDataSource: i(), remoteDataSource: i())),
    //domain/usecases
    Bind((i) => GitHubUserDetails(i())),
    Bind((i) => GithubUserList(i())),
    Bind((i) => SetGithubUserFavorite(i())),
    //bloc
    Bind((i) => GithubUserListBloc(usecase: i())),
    Bind((i) => GithubUserDetailsBloc(usecase: i())),
    Bind((i) => SetGithubUserFavoriteBloc(usecase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => StartPage()),
    ChildRoute('/details',
        child: (_, args) => GithubUserDetailsPage(githubUserName: args.data)),
  ];
}
