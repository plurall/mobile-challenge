import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/core/init_dependencies.dart';
import 'package:mobile_challenge/favorites/view/pages/favorites_page.dart';
import 'package:mobile_challenge/home/view/controllers/github_store.dart';
import 'package:mobile_challenge/home/view/pages/user_details_page.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GithubStore _githubStore;
  TextEditingController _searchQueryController;

  @override
  void initState() {
    super.initState();
    _searchQueryController = TextEditingController();
    _githubStore = getIt<GithubStore>()..findAll(_searchQueryController.text);
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            controller: _searchQueryController,
            decoration: InputDecoration(
              hintText: "Search a user...",
              border: InputBorder.none,
            ),
            onChanged: (String text) {
              _searchQueryController.text = text;
              _githubStore.findAll(_searchQueryController.text);
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _searchQueryController.text = '';
              print(_searchQueryController.text);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FavoritesPage()));
        },
        child: Icon(Icons.favorite),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Observer(builder: (BuildContext context) {
          var data = _githubStore.findAllRequest.value;
          if (_githubStore.findAllRequest.status == FutureStatus.pending) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_searchQueryController.text == '') {
            return Center(child: Text(''));
          } else if (_githubStore.findAllRequest.status ==
              FutureStatus.rejected) {
            return Center(child: Text('Ocorreu um erro.'));
          } else {
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].login),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index].avatarUrl),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsPage(
                                  user: data[index],
                                )));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            );
          }
        }),
      ),
    );
  }
}
