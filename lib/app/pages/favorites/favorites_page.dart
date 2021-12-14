import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/models/favorites_model.dart';
import 'package:mobile_challenge/app/pages/user/user_controller.dart';
import 'package:mobile_challenge/app/pages/users/molecules/custom_switch_widget.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository.dart';
import 'package:mobile_challenge/app/services/client_http_service.dart';
import 'package:mobile_challenge/app/services/favorites_database_service.dart';
import 'package:mobile_challenge/app/viewmodels/apigithub_viewmodel.dart';
import 'package:mobile_challenge/app/viewmodels/favorites_viewmodel.dart';

import '../../app_controller.dart';
import '../../app_theme.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final controller = UserController(
    ApiGithubViewModel(
      ApiGithubRepository(
        ClientHttpService(),
      ),
    ),
    FavoritesViewModel(),
  );

  List<FavoritesModel> favorites = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshFavorites();
  }

  @override
  void dispose() {
    FavoriteDatabaseService.instance.close();

    super.dispose();
  }

  Future refreshFavorites() async {
    setState(() => isLoading = true);
    favorites = await FavoriteDatabaseService.instance.findAll();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppController.instance.themeSwitch,
      builder: (context, isDark, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'E o tempo?',
              style: AppTheme.titleAppBar,
            ),
            toolbarHeight: 100,
            flexibleSpace: Image.asset(
              isDark ? "assets/images/night.jpg" : "assets/images/light.jpg",
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            actions: [
              CustomSwitchWidget(),
            ],
          ),
          body: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : favorites.isEmpty
                    ? const Text("Sem favoritos")
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            final favorite = favorites[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(favorite.login),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            await FavoriteDatabaseService
                                                .instance
                                                .delete(favorite.id);
                                            refreshFavorites();
                                          },
                                        )
                                      ],
                                    ),
                                    Text("e-Mail: ${favorite.email}"),
                                    SizedBox(height: 8),
                                    Text("Localização: ${favorite.location}"),
                                    SizedBox(height: 15),
                                    Text(
                                      favorite.bio,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        );
      },
    );
  }
}
