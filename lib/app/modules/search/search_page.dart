import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/modules/favorites/favorites_page.dart';
import 'package:mobile_challenge/app/modules/search/search_controller.dart';
import 'package:mobile_challenge/app/modules/search/widgets/search_user_card.dart';
import 'package:mobile_challenge/app/modules/global_widgets/empty_message.dart';
import 'package:mobile_challenge/app/modules/global_widgets/loader.dart';

import 'widgets/search_bar.dart';

class SearchPage extends GetView<SearchController> {
  static final route = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Get.toNamed(FavoritesPage.route),
          ),
        ],
        title: Text('Pesquisa'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SearchBar(
            onChanged: (value) => controller.searchText = value,
            onPressed: controller.searchUsers,
          ),
        ),
      ),
      body: Container(
        child: Obx(
          () {
            if (controller.isSearching) return Loader();
            if (controller.usersList.isNotEmpty)
              return ListView.builder(
                itemCount: controller.usersList.length,
                itemBuilder: (context, index) {
                  return SearchUserCard(
                    user: controller.usersList[index],
                  );
                },
              );

            return EmptyMessage(
              text: controller.errorText,
            );
          },
        ),
      ),
    );
  }
}
