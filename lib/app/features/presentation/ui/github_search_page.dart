import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/config/service_locator_config.dart';
import '../../../core/utils/debouncer.dart';
import '../presenters/github_search/github_search_presenter.dart';
import 'components/github_item.dart';
import 'github_favorites_page.dart';

class GithubSearchPage extends StatefulWidget {
  @override
  _GithubSearchPageState createState() => _GithubSearchPageState();
}

class _GithubSearchPageState extends State<GithubSearchPage> {
  final _debouncer = Debouncer(milliseconds: 500);
  final _presenter = getIt.get<GithubSearchPresenter>();

  Future<void> _searchUsers(String text) async {
    _presenter.error = null;
    _presenter.resultSearchList = null;
    await _presenter.searchUsers(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Github Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Observer(
          builder: (context) {
            final _resultSearchList = _presenter.resultSearchList;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => GithubFavoritesPage(),
                        ),
                      );
                    },
                    child: Text('Visualizar favoritos'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (text) {
                      _debouncer.run(() => _searchUsers(text));
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  if (_presenter.isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (_resultSearchList == null)
                    SizedBox(height: 0, width: 0)
                  else if (_resultSearchList.isEmpty ||
                      _presenter.error != null)
                    Text(_presenter.error ?? 'Nenhum resultado encontrado!')
                  else
                    ..._presenter.resultSearchList!
                        .map((item) => GithubItem(resultSearch: item))
                        .toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
