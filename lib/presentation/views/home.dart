import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/presentation/views/favorites.dart';
import 'package:mobile_challenge/presentation/views/search.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<FavoriteUsersProvider>(context, listen: false).loadData(),
        Provider.of<ConnectionProvider>(context, listen: false)
            .checkConnection()
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final isConnected = snapshot.data![1] as bool;
        Provider.of<ConnectionProvider>(context, listen: false)
            .setConnection(isConnected);
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
