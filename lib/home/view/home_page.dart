import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/home/data/service/github_service_impl.dart';
import 'package:mobile_challenge/home/view/stores/github_store.dart';
import 'package:mobile_challenge/home/view/user_details_page.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GithubStore _githubStore;

  @override
  void initState() {
    super.initState();

    _githubStore = GithubStore(GithubServiceImpl(Dio()))..findAll('as');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
          } else if (_githubStore.findAllRequest.status ==
              FutureStatus.rejected) {
            return Center(child: Text('erro'));
          } else {
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].login),
                  leading: Image.network(data[index].avatarUrl),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsPage()));
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
