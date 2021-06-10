import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/local_storage_interface.dart';
import '../bloc/github_user_favorite_bloc.dart';
import '../bloc/github_user_favorite_event.dart';
import '../bloc/github_user_favorite_state.dart';
import '../widget/github_user_favorite_list_widget.dart';

class GithubUserFavoritePage extends StatefulWidget {
  const GithubUserFavoritePage({Key key}) : super(key: key);

  @override
  _GithubUserFavoritePageState createState() => _GithubUserFavoritePageState();
}

class _GithubUserFavoritePageState
    extends ModularState<GithubUserFavoritePage, GithubUserFavoriteBloc> {
  var shared = Modular.get<ILocaStorage>();
  @override
  void initState() {
    bloc.add(GetGithubUsersFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 20,
        ),
        child: BlocProvider(
          create: (_) => bloc,
          child: BlocBuilder<GithubUserFavoriteBloc, GithubUserFavoriteState>(
            builder: (context, state) {
              if (state is Empty) {
                return Container();
              } else if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                return GithubUserFavoriteListWidget(
                  favorite: state.favorite,
                );
              } else if (state is Error) {
                return Text(
                  state.message,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
