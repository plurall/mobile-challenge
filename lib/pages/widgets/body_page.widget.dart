import 'package:flutter/material.dart';
import 'package:mobile_challenge/pages/widgets/favorites_page.widget.dart';
import 'package:mobile_challenge/pages/widgets/list_users_page.widget.dart';

class BodyGetUsersGit extends StatelessWidget {
  const BodyGetUsersGit({
    this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.black,
        tabs: <Tab>[
          Tab(
            child: Text(
              'Usuários',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              'Favoritos',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        controller: tabController,
      ),
      body: TabBarView(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: ListUsersPage(),
          ),
          FavoritesPage(),
        ],
        controller: tabController,
      ),
    );
  }
}
