import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/core/helper/db_helper.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/detail_user/show_detail_user_datasource_impl.dart';
import 'package:mobile_challenge/features/search_user/data/repositories/show_detail_user_repository_impl.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/show_detail_user.dart';
import 'package:mobile_challenge/features/search_user/presenter/details_user_page.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/search_user/search_user_store.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/user_detail/user_detail_store.dart';

import 'features/search_user/data/datasource/search_user/search_user_datasource_impl.dart';
import 'features/search_user/data/repositories/search_user_repository_impl.dart';
import 'features/search_user/domain/usecases/get_all_favorite_local.dart';
import 'features/search_user/domain/usecases/save_favorite_local.dart';
import 'features/search_user/domain/usecases/search_user_by_text.dart';
import 'features/search_user/presenter/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SearchUserStore(i())),
    Bind((i) => UserDetailStore(i(), i(), i())),
    Bind((i) => SearchUserByText(i())),
    Bind((i) => ShowDetailUser(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => ShowDetailUserRepositoryImpl(i())),
    Bind((i) => SearchUserDatasourceImpl(i())),
    Bind((i) => ShowDetailUserDatasourceImpl(i(), i())),
    Bind((i) => SaveFavoriteLocal(i())),
    Bind((i) => GetAllFavoriteLocal(i())),
    Bind((i) => Dio()),
    Bind((i) => DBHelper()),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute(
      '/details_user/:username',
      child: (_, args) => DetailsUserPage(
        username: args.params['username'],
      ),
    ),
  ];
}
