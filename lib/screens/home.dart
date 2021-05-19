import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/Users.dart';
import 'package:mobile_challenge/screens/infoUser.dart';
import 'package:mobile_challenge/web_apis/getUsers.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários do Git'),
      ),
      body: _body(),
    );
  }

  _body() {
    Future<List<Users>> notasFiscais = GetGitUsersAPI.getGitUsers();
    return FutureBuilder(
      future: notasFiscais,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Erro ao acessar os dados");
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<Users> grupoDeUsers = snapshot.data;
        return _listView(grupoDeUsers);
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
                user.login,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('DETALHES'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoUser(
                              infoUser: user)));
                            
                },
              ),
            ],
          ));
        },
      ),
    );
  }
}
