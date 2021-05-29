import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/controller/github_controller.dart';
import 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GithubController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Github API'),
          centerTitle: true,
        ),
        body: Obx(() => controller.index.value == 0 ? SearchPage() : FavoritesPage()),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: (index) => controller.pressedButtonNavigatonBottomBar(index),
            items: [
              BottomNavigationBarItem(
                label: 'Pesquisar',
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: 'Favoritos',
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
