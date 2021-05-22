import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/modules/user_details/data/datasources/user_detail_local_data_source.dart';
import 'package:mobile_challenge/modules/user_details/data/datasources/user_detail_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_details/data/repositories/github_user_api_repository.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_user.dart';
import 'package:mobile_challenge/modules/user_details/presentation/widgets/user_details_card.dart';
import 'package:mobile_challenge/shared/widgets/loading.dart';
import 'package:mobile_challenge/shared/widgets/message.dart';
import 'package:mobile_challenge/utils/palette.dart';
import 'package:http/http.dart' as http;

import 'bloc/user_detail_bloc.dart';
import 'bloc/user_detail_event.dart';
import 'bloc/user_detail_state.dart';

class UserDetailsPage extends StatelessWidget {
  http.Client client;
  UserDetailRemoteDataSource remoteDataSource;
  UserDetailLocalDataSource localDataSource;
  GetUser getUserUseCase;
  GithubUserApiRepository repo;
  final String nickname;

  UserDetailsPage(this.nickname) {
    client = http.Client();
    remoteDataSource = UserDetailRemoteDataSource(client: client);
    localDataSource = UserDetailLocalDataSource();
    repo = GithubUserApiRepository(
        localDataSource: localDataSource, remoteDataSource: remoteDataSource);
    getUserUseCase = GetUser(repo);
  }

  @override
  Widget build(BuildContext context) {
    void callUserRequest(BuildContext ctx) {
      BlocProvider.of<UserDetailBloc>(ctx).add(GetUserEvent(nickname));
    }

    return Scaffold(
      backgroundColor: Palette.backgroundDarkBlack,
      appBar: AppBar(
        title: Text('User'),
      ),
      body: BlocProvider(
        create: (_) => UserDetailBloc(getUser: getUserUseCase),
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is Empty || state == null) {
              callUserRequest(context);
              return LoadingWidget();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              return UserDetailsCard(state.user);
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
