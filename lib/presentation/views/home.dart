import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<FavoriteUsersProvider>(context, listen: false).loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Usuários do Github'),
              bottom: TabBar(tabs: [
                Tab(
                  text: 'Busca',
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: 'Favoritos',
                  icon: Icon(Icons.star),
                ),
              ]),
            ),
            body: TabBarView(
              children: [
                SearchView(),
                FavoritesView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
