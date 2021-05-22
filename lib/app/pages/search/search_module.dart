import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/pages/search/search_page.dart';
import 'package:mobile_challenge/app/pages/search/search_page_bloc.dart';
import 'package:mobile_challenge/app/pages/search/search_repository.dart';
import 'package:mobile_challenge/app/pages/user_detail/user_detail_page_bloc.dart';
import 'package:mobile_challenge/app/shared/custom_dio/custom_dio.dart';

import '../../app.module.dart';

class SearchModule extends ModuleWidget {
  @override
  // TODO: implement blocs
  List<Bloc<BlocBase>> get blocs => [
        Bloc((i) => SearchPageBlock(i.get<SearchRepository>())),
        Bloc((i) => UserDetailPageBlock()),
      ];

  @override
  // TODO: implement dependencies
  List<Dependency> get dependencies => [
        Dependency(
            (i) => SearchRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  // TODO: implement view
  Widget get view => SearchPage();

  static Inject get to => Inject<SearchModule>.of();
}
