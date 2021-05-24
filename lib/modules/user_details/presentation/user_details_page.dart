import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/modules/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_challenge/modules/user_details/data/datasources/user_detail_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_details/data/repositories/favorite_user_repository.dart';
import 'package:mobile_challenge/modules/user_details/data/repositories/github_user_api_repository.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_is_favorite.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_user.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/set_toggle_user_favorite.dart';
import 'package:mobile_challenge/modules/user_details/presentation/widgets/user_details_card.dart';
import 'package:mobile_challenge/shared/datasources/favorites_local_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';
import 'package:mobile_challenge/shared/widgets/loading.dart';
import 'package:mobile_challenge/shared/widgets/message.dart';
import 'package:mobile_challenge/utils/palette.dart';
import 'package:http/http.dart' as http;

import 'bloc/user_detail_bloc.dart';
import 'bloc/user_detail_event.dart';
import 'bloc/user_detail_state.dart';

class UserDetailsPage extends StatefulWidget {
  UserDetailsPage(this.nickname);
  final String nickname;

  @override
  State<StatefulWidget> createState() => _UserDetailsPage();
}

class _UserDetailsPage extends State<UserDetailsPage> {
  http.Client client;
  UserDetailRemoteDataSource remoteDataSource;
  FavoritesLocalDataSource localDataSource;
  GetUser getUserUseCase;
  GetIsFavorite getIsFavoriteUseCase;
  SetToggleUserFavorite setToggleFavoriteUseCase;
  GithubUserApiRepository repo;
  FavoriteUserRepository localrepo;

  _UserDetailsPage() {
    client = http.Client();
    remoteDataSource = UserDetailRemoteDataSource(client: client);
    localDataSource = FavoritesLocalDataSource();
    repo = GithubUserApiRepository(remoteDataSource: remoteDataSource);
    localrepo = FavoriteUserRepository(localDataSource: localDataSource);
    getUserUseCase = GetUser(repo);
    getIsFavoriteUseCase = GetIsFavorite(localrepo);
    setToggleFavoriteUseCase = SetToggleUserFavorite(localrepo);
  }

  @override
  Widget build(BuildContext context) {
    void callUserRequest(BuildContext ctx) {
      BlocProvider.of<UserDetailBloc>(ctx).add(GetUserEvent(widget.nickname));
    }

    void handleToggleFavorite(BuildContext ctx, User user) {
      BlocProvider.of<UserDetailBloc>(ctx).add(GetToggleFavoriteEvent(user));
    }

    return Scaffold(
      backgroundColor: Palette.backgroundDarkBlack,
      appBar: AppBar(
        title: Text('User'),
      ),
      body: BlocProvider(
        create: (_) => UserDetailBloc(
          getUser: getUserUseCase,
          isFavorite: getIsFavoriteUseCase,
          toggleFavorite: setToggleFavoriteUseCase,
        ),
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is Empty || state == null) {
              callUserRequest(context);
              return LoadingWidget();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              return UserDetailsCard(
                  state.user, () => handleToggleFavorite(context, state.user));
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
