import 'package:mobile_challenge/app/views/favorite/favorite.dart';
import 'package:mobile_challenge/app/views/search/search.dart';
import 'package:mobile_challenge/app/views/about/about.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> telas=[
      Search(),
      Favorites(),
      About()
    ];

    return Scaffold(
      body:Container(
        child: telas[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _index,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Pesquisa'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Favoritos'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              title: Text('Sobre')
          )
        ],
      ),
    );
  }
}
