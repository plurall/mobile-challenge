import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../core/config/service_locator_config.dart';
import '../presenters/github_favorites/github_favorites_presenter.dart';

class GithubFavoritesPage extends StatefulWidget {
  const GithubFavoritesPage({Key? key}) : super(key: key);

  @override
  _GithubFavoritesPageState createState() => _GithubFavoritesPageState();
}

class _GithubFavoritesPageState extends State<GithubFavoritesPage> {
  final _presenter = getIt.get<GithubFavoritesPresenter>();
  var _disposer;

  @override
  void initState() {
    _presenter.getFavoritesUsers();
    _disposer = reaction((r) => _presenter.error, (_) {
      final error = _presenter.error;
      if (error != null && error.isNotEmpty) {
        showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: Text('Atenção!'),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                )
              ],
            );
          },
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de favoritos'),
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
        final _favoritesUsersList = _presenter.favoritesUsersList;
        if (_favoritesUsersList == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_favoritesUsersList.isEmpty) {
          return Center(
            child: Text('Lista de favoritos vazia.'),
          );
        }
        return ListView.builder(
          itemCount: _favoritesUsersList.length,
          itemBuilder: (builder, idx) {
            final _favoriteUser = _favoritesUsersList[idx];
            return ListTile(
              title: Text(_favoriteUser.username),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await _presenter.setFavorite(_favoriteUser.username);
                  await _presenter.getFavoritesUsers();
                },
              ),
            );
          },
        );
      }),
    );
  }
}
