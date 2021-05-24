import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/modules/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:mobile_challenge/modules/favorites/data/repositories/favorites_repository.dart';
import 'package:mobile_challenge/modules/favorites/domain/usecases/get_favorite_list.dart';
import 'package:mobile_challenge/modules/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mobile_challenge/modules/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_challenge/modules/favorites/presentation/bloc/favorites_state.dart';
import 'package:mobile_challenge/modules/user_details/presentation/user_details_page.dart';
import 'package:mobile_challenge/shared/widgets/user_card.dart';
import 'package:mobile_challenge/shared/widgets/loading.dart';
import 'package:mobile_challenge/shared/widgets/message.dart';
import 'package:mobile_challenge/utils/palette.dart';

import 'package:http/http.dart' as http;

class FavoritesPage extends StatelessWidget {
  http.Client client;
  FavoritesLocalDataSource localDataSource;
  GetFavoriteList favoritesUseCase;
  FavoritesRepository repo;

  FavoritesPage() {
    client = http.Client();
    localDataSource = FavoritesLocalDataSource();
    repo = FavoritesRepository(localDataSource: localDataSource);
    favoritesUseCase = GetFavoriteList(repo);
  }

  @override
  Widget build(BuildContext context) {
    void callDefaultList(BuildContext ctx) {
      BlocProvider.of<FavoritesBloc>(ctx).add(GetFavoritesEvent());
    }

    void handleCardClick(String nickname) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => UserDetailsPage(nickname)));
    }

    return Scaffold(
      backgroundColor: Palette.backgroundDarkBlack,
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocProvider(
        create: (_) => FavoritesBloc(favoritesUseCase: favoritesUseCase),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is Empty || state == null) {
              callDefaultList(context);
              return LoadingWidget();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              return Column(
                children: [
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
