import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/app_theme.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:mobile_challenge/app/pages/users/users_controller.dart';
import 'package:mobile_challenge/app/pages/users/molecules/card_users_widget.dart.dart';
import 'package:mobile_challenge/app/pages/users/molecules/custom_circular_progress_indicator_widget.dart';
import 'package:mobile_challenge/app/pages/users/molecules/custom_switch_widget.dart';
import 'package:mobile_challenge/app/pages/user/user_controller.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository.dart';
import 'package:mobile_challenge/app/services/client_http_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_challenge/app/services/favorites_database_service.dart';
import 'package:mobile_challenge/app/viewmodels/apigithub_viewmodel.dart';
import 'package:mobile_challenge/app/viewmodels/favorites_viewmodel.dart';

class UserPage extends StatefulWidget {
  UsersModel usersModel;
  UserPage({Key key, this.usersModel}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controller = UserController(
    ApiGithubViewModel(
      ApiGithubRepository(
        ClientHttpService(),
      ),
    ),
    FavoritesViewModel(),
  );

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller.getFindOne(widget.usersModel.login);
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
          body: ValueListenableBuilder<UserModel>(
              valueListenable: controller.findOne,
              builder: (context, model, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 85,
                          backgroundColor: Color(0xffFDCF09),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/${model?.login}"),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text("Nickname: ${model?.login}"),
                        Text("e-Mail: ${model?.email}"),
                        Text("Localizacao: ${model?.location}"),
                        SizedBox(height: 20),
                        Text(
                          "bio: ${model?.bio}",
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                            child: Text("Favoritar perfil"),
                            onPressed: () {
                              controller.addFavoriteItem(
                                  model?.login,
                                  model?.email,
                                  model?.location,
                                  model?.bio,
                                  model?.id);
                            })
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
