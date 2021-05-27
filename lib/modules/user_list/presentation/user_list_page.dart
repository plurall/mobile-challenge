import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/modules/favorites/presentation/favorites_page.dart';
import 'package:mobile_challenge/modules/user_details/presentation/user_details_page.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_search_api_repository.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_default_user_list.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_new_page_user_search.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_user_search.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_event.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_state.dart';
import 'package:mobile_challenge/modules/user_list/presentation/widgets/search_bar.dart';
import 'package:mobile_challenge/shared/widgets/loading.dart';
import 'package:mobile_challenge/shared/widgets/message.dart';
import 'package:mobile_challenge/shared/widgets/user_card.dart';
import 'package:mobile_challenge/utils/palette.dart';

import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  final http.Client client;
  UserListRemoteDataSourceProtocol remoteDataSource;
  GetUserSearch searchUseCase;
  GetDefaultUserList defaultListUseCase;
  GetNewPageUserSearch newPageUserUseCase;
  GithubSearchApiRepository repo;
  UserListPage({
    this.client,
    this.remoteDataSource,
    this.searchUseCase,
    this.defaultListUseCase,
    this.newPageUserUseCase,
    this.repo,
  });

  @override
  State<StatefulWidget> createState() => _UserListPage(
        client: client,
        remoteDataSource: remoteDataSource,
        searchUseCase: searchUseCase,
        defaultListUseCase: defaultListUseCase,
        newPageUserUseCase: newPageUserUseCase,
        repo: repo,
      );
}

class _UserListPage extends State<UserListPage> {
  http.Client client;
  UserListRemoteDataSourceProtocol remoteDataSource;
  GetUserSearch searchUseCase;
  GetDefaultUserList defaultListUseCase;
  GetNewPageUserSearch newPageUserUseCase;
  GithubSearchApiRepository repo;

  _UserListPage({
    this.client,
    this.remoteDataSource,
    this.searchUseCase,
    this.defaultListUseCase,
    this.newPageUserUseCase,
    this.repo,
  });

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  static const String DEFAULT_SEARCH = 'followers:>10000';

  String _loadedQuery = '';
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    void callUserSearch(BuildContext ctx, String query) {
      setState(() {
        _currentPage = 1;
        _loadedQuery = query;
        if (_loadedQuery.isEmpty) {
          _loadedQuery = DEFAULT_SEARCH;
        }
      });
      print("searching");
      print(_loadedQuery);
      BlocProvider.of<UserListBloc>(ctx).add(
        GetUserSearchEvent(query),
      );
    }

    void callLoadMore(BuildContext ctx) {
      setState(() {
        if (_loadedQuery.isEmpty) {
          _loadedQuery = DEFAULT_SEARCH;
        }
        _currentPage++;
      });
      BlocProvider.of<UserListBloc>(ctx).add(
        GetNewPageUserSearchEvent(_loadedQuery, _currentPage),
      );
    }

    void callDefaultList(BuildContext ctx) {
      BlocProvider.of<UserListBloc>(ctx).add(
        GetDefaultUserListEvent(),
      );
    }

    void handleCardClick(String nickname) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserDetailsPage(nickname),
          ));
    }

    void handleFavoritesListClick() {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => FavoritesPage()));
    }

    return Scaffold(
      backgroundColor: Palette.backgroundDarkBlack,
      appBar: AppBar(
        title: Text('Github User List'),
        actions: [
          IconButton(
            onPressed: () => handleFavoritesListClick(),
            icon: Icon(
              Icons.star_border,
              color: Palette.darkWhiteText,
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => UserListBloc(
          search: searchUseCase,
          empty: defaultListUseCase,
          newPage: newPageUserUseCase,
        ),
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is Empty || state == null) {
              callDefaultList(context);
              return LoadingWidget();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              int length = state.users.length;

              return Column(
                children: [
                  SearchBar(
                    onclick: () =>
                        callUserSearch(context, _searchController.text),
                    controller: _searchController,
                  ),
                  Expanded(
                      child: ListView.builder(
                    key: Key('UserListPageListView'),
                    itemCount: length + 1,
                    itemBuilder: (ctx, index) {
                      if (index == length) {
                        if (state.hasMore) {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () => callLoadMore(context),
                              child: Text("Load More"),
                            ),
                          );
                        }
                        return SizedBox();
                      }
                      return UserCardWidget(
                        state.users[index],
                        handleCardClick,
                      );
                    },
                  )),
                ],
              );
            } else if (state is Error) {
              return Column(
                children: [
                  SearchBar(
                    onclick: () =>
                        callUserSearch(context, _searchController.text),
                    controller: _searchController,
                  ),
                  Expanded(
                    child: MessageWidget(
                      icon: state.icon,
                      text: state.message,
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
