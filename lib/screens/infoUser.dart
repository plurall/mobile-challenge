import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/User.dart';
import 'package:mobile_challenge/models/Users.dart';
import 'package:mobile_challenge/webApis/getUser.dart';

import 'home.dart';

class InfoUser extends StatefulWidget {
  InfoUser({this.infoUser});
  final infoUser;
  @override
  _InfoUserState createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _body(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      // titulo da tela.
      title: _loginDoUser(),
    );
  }

  _loginDoUser() {
    var user = widget.infoUser;
    return Text(user.login);
  }

  _body() {
    Users userOfList = widget.infoUser;
    Future<User> user = GetGitUserAPI.getGitUser(userOfList.login);
    return FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erro ao acessar os dados");
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          User userAtual = snapshot.data;
          return Center(
            child: Container(
              //padding: EdgeInsets.all(5),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    leading: Image.network(
                      _validaCampo(userAtual.avatarUrl),
                      width: 150,
                      height: 150,
                    ),
                    title: Text(
                      _validaCampo(userAtual.name),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      _validaCampo(userAtual.bio),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      _validaCampo(userAtual.email),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(
                        _validaCampo(userAtual.location),
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          );
        });
  }

  String _validaCampo(String texto) {
    if (texto != null) {
      return texto;
    } else {
      return "não se encontra na API";
    }
  }
}
