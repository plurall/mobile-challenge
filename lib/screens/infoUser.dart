import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/User.dart';
import 'package:mobile_challenge/models/Users.dart';
import 'package:mobile_challenge/webAis/getUser.dart';


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
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.network(
                          "avatar",
                          width: 250,
                          height: 250,
                        ),
                        title: Text(
                          "nickname",
                          style: TextStyle(fontSize: 30),
                        ),
                        subtitle: Text(
                          "bio",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        "email",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "location",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
