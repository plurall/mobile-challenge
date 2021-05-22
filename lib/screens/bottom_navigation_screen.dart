import 'package:flutter/material.dart';

import '/screens/favorites_screen.dart';
import '/screens/home.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Map<String, dynamic>> _screens = [
    {
      'screen': Home(),
      'title': 'Pesquisar',
    },
    {
      'screen': FavoritesScreen(),
      'title': 'Favoritos',
    },
  ];

  int _choosedScreen = 0;

  void _chooseScreen(int index) {
    setState(() {
      _choosedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_screens[_choosedScreen]['title']),
        ),
        body: _screens[_choosedScreen]['screen'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _chooseScreen,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          currentIndex: _choosedScreen,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Procurar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favoritos'),
          ],
        ),
      ),
    );
  }
}
