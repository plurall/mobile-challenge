import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/core/init_dependencies.dart';
import 'package:mobile_challenge/favorites/view/controllers/favorites_controller.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';
import 'package:mobile_challenge/home/view/controllers/github_store.dart';
import 'package:mobx/mobx.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;

  const UserDetailsPage({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  GithubStore _githubStore;
  FavoritesStore _favoritesStore;

  @override
  void initState() {
    super.initState();
    _githubStore = getIt<GithubStore>()..findById(widget.user.id);
    _favoritesStore = getIt<FavoritesStore>()..findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          if (_githubStore.findByIdRequest.status == FutureStatus.pending) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_githubStore.findByIdRequest.status ==
              FutureStatus.rejected) {
            return Center(child: Text('Ocorreu um erro.'));
          } else {
            return Text(_githubStore.findByIdRequest.value.login);
          }
        }),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                _favoritesStore.save(widget.user);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Você adicionou um favorito!"),
                ));
              }),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Observer(builder: (BuildContext context) {
            var data = _githubStore.findByIdRequest.value;
            if (_githubStore.findByIdRequest.status == FutureStatus.pending) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_githubStore.findByIdRequest.status ==
                FutureStatus.rejected) {
              return Center(child: Text('Ocorreu um erro.'));
            } else {
              return _buildUserDetails(data);
            }
          })),
    );
  }

  Column _buildUserDetails(User data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Center(
          child: CircleAvatar(
            radius: 90.0,
            backgroundImage: NetworkImage(data.avatarUrl),
          ),
        ),
        SizedBox(height: 40.0),
        Text(
          data.email,
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          data.location,
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          data.bio,
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}
