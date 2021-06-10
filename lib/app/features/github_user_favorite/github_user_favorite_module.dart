import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/github_user_favorite_local_data_source.dart';
import 'data/repositories/github_user_favorite_repository_impl.dart';
import 'domain/usecases/get_github_user_favorite.dart';
import 'presentation/bloc/github_user_favorite_bloc.dart';
import 'presentation/page/favorite_user_page.dart';

class GithubUserFavoriteModule extends Module {
  @override
  final List<Bind> binds = [
    // data/datasource
    Bind<GithubUserFavotireLocalDataSource>(
        (i) => GithubUserFavoriteDataSourceImpl(i())),
    // data/repository
    Bind((i) => GithubUserFavoriteRepositoryImpl(i())),
    // domain/ usecase
    Bind((i) => GetGithubUserFavorite(i())),
    //bloc
    Bind((i) => GithubUserFavoriteBloc(usecase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => GithubUserFavoritePage()),
  ];
}
