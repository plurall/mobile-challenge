import 'package:flutter/material.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
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
  }
}
