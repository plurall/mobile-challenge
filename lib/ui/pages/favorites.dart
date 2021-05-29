import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/controller/github_controller.dart';
import '../../features/data/repositories/database_repositories.dart';
import '../../features/utils/routes.dart';
import '../components/app_theme.dart';

class FavoritesPage extends GetView<GithubController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseRepositories.getProfiles(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (DatabaseRepositories.favoritesProfiles.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 5),
              child: ListView.builder(
                itemCount: DatabaseRepositories.favoritesProfiles.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: primaryColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.grey[500],
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        var profile = DatabaseRepositories.favoritesProfiles
                            .elementAt(index);
                        controller.setGithubProfileFromDatabase(profile);
                        Get.toNamed(Routes.PROFILE_PAGE_FROM_DATABASE);
                      },
                      child: ListTile(
                        title: Text(
                          DatabaseRepositories.favoritesProfiles
                              .elementAt(index)
                              .login
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
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
      },
    );
  }
}
