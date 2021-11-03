import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/models/user_model.dart';
import 'package:mobile_challenge/services/app_service.dart';

class FavoriteUsersPage extends StatefulWidget {
  const FavoriteUsersPage({Key key}) : super(key: key);

  @override
  State<FavoriteUsersPage> createState() => _FavoriteUsersPageState();
}

class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
  AppService appService = Modular.get<AppService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: _listUsers(),
    );
  }

  Widget _listUsers() {
    List<UserModel> users = appService.favoriteUsers;
    return users.length > 0
        ? ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () =>
                    Modular.to.pushNamed('/user/${users[index].login}'),
                title: Text(users[index].login),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              );
            })
        : Center(
            child: Text('Nenhum usuário favoritado.'),
          );
  }
}
