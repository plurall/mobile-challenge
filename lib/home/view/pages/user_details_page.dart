import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/home/data/service/github_service.dart';
import 'package:mobile_challenge/home/data/service/github_service_impl.dart';
import 'package:mobile_challenge/home/domain/usecases/find_all_users.dart';
import 'package:mobile_challenge/home/domain/usecases/find_user_by_id.dart';
import 'package:mobile_challenge/home/view/controllers/github_store.dart';
import 'package:mobx/mobx.dart';

class UserDetailsPage extends StatefulWidget {
  final int userId;

  const UserDetailsPage({
    Key key,
    @required this.userId,
  }) : super(key: key);
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  GithubStore _githubStore;
  GithubService _githubService;

  @override
  void initState() {
    super.initState();
    _githubService = GithubServiceImpl(Dio());
    _githubStore = GithubStore(FindAllUsers(_githubService), FindUserById(_githubService))
      ..findById(widget.userId);
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
            return Center(child: Text('erro'));
          } else {
            return Text(_githubStore.findByIdRequest.value.login);
          }
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
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
              return Center(child: Text('erro'));
            } else {
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
          })),
    );
  }
}
