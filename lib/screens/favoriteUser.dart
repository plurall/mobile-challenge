import 'package:flutter/material.dart';
import 'package:mobile_challenge/databases/dbUser.dart';
import 'package:mobile_challenge/models/User.dart';

class FavoriteUser extends StatefulWidget {
  @override
  _FavoriteUserState createState() => _FavoriteUserState();
}

class _FavoriteUserState extends State<FavoriteUser> {
  DataBaseHelper db = DataBaseHelper();
  List<User> usersFavoritos;

  @override
  void initState() {
    super.initState();

    db.getAllUsers().then((lista) {
      setState(() {
        usersFavoritos = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Favoritos'),
        ),
        body: ListView.builder(
          itemCount: usersFavoritos.length != null ? usersFavoritos.length : 0,
          itemBuilder: (context, index) {
            return _listaDeUsers(context, index);
          },
        ));
  }

  _listaDeUsers(context, index) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            usersFavoritos[index].login,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Column(
            children: [
              Text(
                usersFavoritos[index].name,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                usersFavoritos[index].bio,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                usersFavoritos[index].location,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
