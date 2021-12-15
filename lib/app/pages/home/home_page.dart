import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/app_theme.dart';
import 'package:mobile_challenge/app/models/favorites_model.dart';
import 'package:mobile_challenge/app/pages/favorites/favorites_page.dart';
import 'package:mobile_challenge/app/pages/users/users_page.dart';
import 'package:mobile_challenge/app/services/favorites_database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pages = [UsersPage(), FavoritesPage()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages.elementAt(_selectedIndex),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.purple,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Usuários"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: "Favoritos"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppTheme.primaryColorLight,
            unselectedItemColor: Colors.white,
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: (value) {
              _selectedIndex = value;
              setState(() {});
            },
          ),
        ));
  }
}
