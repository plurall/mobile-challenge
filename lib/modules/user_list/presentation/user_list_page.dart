import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/modules/user_details/presentation/user_details_page.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_local_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_search_api_repository.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_default_user_list.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_user_search.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_event.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_state.dart';
import 'package:mobile_challenge/modules/user_list/presentation/widgets/user_card.dart';
import 'package:mobile_challenge/shared/widgets/loading.dart';
import 'package:mobile_challenge/shared/widgets/message.dart';
import 'package:mobile_challenge/utils/palette.dart';

import 'package:http/http.dart' as http;

class UserListPage extends StatelessWidget {
  http.Client client;
  UserListRemoteDataSource remoteDataSource;
  UserListLocalDataSource localDataSource;
  GetUserSearch searchUseCase;
  GetDefaultUserList defaultListUseCase;
  GithubSearchApiRepository repo;

  UserListPage() {
    client = http.Client();
    remoteDataSource = UserListRemoteDataSource(client: client);
    localDataSource = UserListLocalDataSource();
    repo = GithubSearchApiRepository(
        localDataSource: localDataSource, remoteDataSource: remoteDataSource);
    searchUseCase = GetUserSearch(repo);
    defaultListUseCase = GetDefaultUserList(repo);
  }

  @override
  Widget build(BuildContext context) {
    void callUserSearch(BuildContext ctx, String query) {
      BlocProvider.of<UserListBloc>(ctx).add(GetUserSearchEvent(query));
    }

    void callDefaultList(BuildContext ctx) {
      BlocProvider.of<UserListBloc>(ctx).add(GetDefaultUserListEvent());
    }

    void handleCardClick(String nickname) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => UserDetailsPage(nickname)));
    }

    return Scaffold(
      backgroundColor: Palette.backgroundDarkBlack,
      appBar: AppBar(
        title: Text('Github User List'),
      ),
      body: BlocProvider(
        create: (_) =>
            UserListBloc(search: searchUseCase, empty: defaultListUseCase),
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is Empty || state == null) {
              callDefaultList(context);
              return LoadingWidget();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              return Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: Palette.darkWhiteText,
                    ),
                    onFieldSubmitted: (val) => callUserSearch(context, val),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (ctx, index) {
                        return UserCardWidget(
                          state.users[index],
                          handleCardClick,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is Error) {
              return MessageWidget(
                text: state.message,
              );
            }
          },
        ),
      ),
    );
  }
}
