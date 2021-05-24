import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api/controller/databaseController.dart';
import 'package:github_api/controller/githubController.dart';
import 'package:github_api/utils/routes.dart';

class FavoritesPage extends GetView<GithubController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseFavoriteController.getProfiles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (DatabaseFavoriteController.favoritesProfiles.isNotEmpty) {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 2,
                ),
                itemCount: DatabaseFavoriteController.favoritesProfiles.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(179, 24, 97, 1.0),
                        Color.fromRGBO(159, 26, 116, 1.0),
                        Color.fromRGBO(146, 28, 131, 1.0),
                        Color.fromRGBO(122, 29, 153, 1.0),
                      ]),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-3, -3),
                          color: Colors.white,
                          blurRadius: 2,
                        ),
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.grey[500]!,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        var profile = DatabaseFavoriteController
                            .favoritesProfiles
                            .elementAt(index);
                        controller.setGithubProfileFromDatabase(profile);
                        Get.toNamed(Routes.PROFILE_PAGE_FROM_DATABASE);
                      },
                      child: ListTile(
                        title: Text(
                          DatabaseFavoriteController.favoritesProfiles
                              .elementAt(index)
                              .login
                              .toUpperCase(),
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text('NENHUM FAVORITO ADICIONADO'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
