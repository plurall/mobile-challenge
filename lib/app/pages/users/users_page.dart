import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/app_theme.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:mobile_challenge/app/pages/users/users_controller.dart';
import 'package:mobile_challenge/app/pages/users/molecules/card_users_widget.dart.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository.dart';
import 'package:mobile_challenge/app/services/client_http_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_challenge/app/viewmodels/apigithub_viewmodel.dart';
import 'molecules/custom_circular_progress_indicator_widget.dart';
import 'molecules/custom_switch_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final controller = UsersController(
    ApiGithubViewModel(
      ApiGithubRepository(
        ClientHttpService(),
      ),
    ),
  );

  bool isLoading = false;
  String name = '';

  init() async {
    setState(() {
      isLoading = true;
    });

    if (name != null) {
      await controller.getFindAll(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppController.instance.themeSwitch,
      builder: (context, isDark, child) {
        return Scaffold(
          appBar: AppBar(
            title: Card(
              child: TextFormField(
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.search),
                  hintText: ' Procurar...',
                ),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            toolbarHeight: 100,
            flexibleSpace: Image.asset(
              isDark ? "assets/images/night.jpg" : "assets/images/light.jpg",
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    init();
                  },
                  icon: Icon(FontAwesomeIcons.search)),
              CustomSwitchWidget(),
            ],
          ),
          body: ValueListenableBuilder<List<UsersModel>>(
              valueListenable: controller.findAll,
              builder: (context, users, child) {
                if (users == null || users.isEmpty || name == null)
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                        child: Text(
                      "Insira algum nome em procurar e clique na lupa.",
                      style: AppTheme.textBody,
                      textAlign: TextAlign.center,
                    )),
                  );
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return CardUsersWidget(model: users[index]);
                    });
              }),
        );
      },
    );
  }
}
