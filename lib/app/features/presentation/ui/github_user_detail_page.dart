import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../core/config/service_locator_config.dart';
import '../presenters/github_favorites/github_favorites_presenter.dart';
import '../presenters/github_user_detail/github_user_detail_presenter.dart';

class GithubUserDetailPage extends StatefulWidget {
  final String username;

  const GithubUserDetailPage({Key? key, required this.username})
      : super(key: key);

  @override
  _GithubUserDetailPageState createState() => _GithubUserDetailPageState();
}

class _GithubUserDetailPageState extends State<GithubUserDetailPage> {
  final _presenter = getIt.get<GithubUserDetailPresenter>();
  final _presenterFavorites = getIt.get<GithubFavoritesPresenter>();

  var _disposer;

  @override
  void initState() {
    _presenter.getUserData(widget.username);
    _presenterFavorites.getFavoritesUsers().then((_) {
      final _favoritesUsersList = _presenterFavorites.favoritesUsersList;
      if (_favoritesUsersList!
          .any((element) => element.username == widget.username)) {
        _presenterFavorites.isFavorite = true;
      }
    });
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
        centerTitle: true,
        title: Text('Detalhes do usuário'),
      ),
      body: Observer(
        builder: (context) {
          if (_presenter.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final _user = _presenter.user;
          if (_user == null) {
            return Center(
              child: Text('Não foi possível carregar os dados do usuário.'),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _user.imageUrl?.isNotEmpty == true
                              ? Image.network(_user.imageUrl!)
                              : SizedBox(height: 0, width: 0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _user.username,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () async {
                              await _presenterFavorites.setFavorite(
                                _user.username,
                              );
                            },
                            child: Icon(
                              _presenterFavorites.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(_user.location ?? ''),
                      SizedBox(height: 8),
                      Text(_user.bio ?? ''),
                      SizedBox(height: 8),
                      Text(_user.email ?? ''),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
