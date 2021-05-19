import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/User.dart';
import 'package:mobile_challenge/web_apis/getUser.dart';

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
      appBar: AppBar(
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
      ),
      body: _body(),
    );
  }

  _loginDoUser() {
    var user = widget.infoUser;
    return Text(user.login);
  }

  _body() {
    var userOfList = widget.infoUser;
    var user = GetGitUserAPI.getGitUser(userOfList.login);
    return FutureBuilder(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Erro ao acessar os dados");
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        User detalheDoUser = snapshot.data;
        return _listView(detalheDoUser);
      },
    );
  }

   _listView(grupoDeUsers) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: grupoDeUsers != null ? grupoDeUsers.length : 0,
        itemBuilder: (context, index) {
          var user = grupoDeUsers[index];
          return Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(user.avatarUrl),
              Text(
                user.bio,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ));
        },
      ),
    );
  }
}
