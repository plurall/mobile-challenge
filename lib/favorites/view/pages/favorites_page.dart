import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/core/init_dependencies.dart';
import 'package:mobile_challenge/favorites/view/controllers/favorites_controller.dart';
import 'package:mobile_challenge/home/view/pages/user_details_page.dart';
import 'package:mobx/mobx.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoritesStore _favoritesStore;

  @override
  void initState() {
    super.initState();
    _favoritesStore = getIt<FavoritesStore>()..findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Observer(builder: (BuildContext context) {
          if (_favoritesStore.findAllRequest.value == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_favoritesStore.findAllRequest?.status == FutureStatus.pending) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_favoritesStore.findAllRequest?.status ==
              FutureStatus.rejected) {
            return Center(child: Text('Ocorreu um erro.'));
          } else {
            var data = _favoritesStore.findAllRequest?.value;

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
