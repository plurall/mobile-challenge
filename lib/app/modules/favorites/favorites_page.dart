import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/modules/favorites/favorites_controller.dart';
import 'package:mobile_challenge/app/modules/favorites/widgets/favorite_card.dart';
import 'package:mobile_challenge/app/modules/global_widgets/empty_message.dart';

class FavoritesPage extends GetView<FavoritesController> {
  static final route = '/favorites';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Container(
        child: Obx(
          () {
            if (controller.favoritesList.isNotEmpty)
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: controller.favoritesList.length,
                itemBuilder: (context, index) {
                  return FavoriteCard(user: controller.favoritesList[index]);
                },
              );

            return EmptyMessage(
              text: 'Nenhum usuário favoritado',
            );
          },
        ),
      ),
    );
  }
}
