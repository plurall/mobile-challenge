import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/features/github/presentation/pages/bookmarks_page.dart';
import 'package:mobile_challenge/features/github/presentation/pages/search_page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int currentIndex = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github'),
      ),
      body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SearchPage(),
            BookmarksPage(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: 'Salvos'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              currentIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}
