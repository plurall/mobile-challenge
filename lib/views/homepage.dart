import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api/controller/githubController.dart';
import 'package:github_api/views/favorites.dart';
import 'package:github_api/views/search.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GithubController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Github API'),
        ),
        body: Obx(
            () => controller.index.value == 0 ? SearchPage() : FavoritesPage()),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (index) =>
                  controller.pressedButtonNavigatonBottomBar(index),
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
              ]),
        ),
      ),
    );
  }
}
