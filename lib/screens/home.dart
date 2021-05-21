import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/Users.dart';
import 'package:mobile_challenge/screens/infoUser.dart';
import 'package:mobile_challenge/webApis/getUsers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isFavorited = false;
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
    Future<List<Users>> grupoDeUsuariosFuture = GetGitUsersAPI.getGitUsers();
    return FutureBuilder(
      future: grupoDeUsuariosFuture,
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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image.network(
                  user.avatarUrl,
                  width: 100,
                  height: 100,
                ),
                title: Text(
                  user.login,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('DETALHES'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoUser(infoUser: user)));
                    },
                  ),
                  InkWell(
                    child: Icon(
                      Icons.star,
                      size: 30,
                      color: _isFavorited ? Colors.yellow : Colors.blue,
                    ),
                    onTap: () {
                      _toggleFavorite(user);
                    },
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }

  void _toggleFavorite(Users user) {
    print(_isFavorited);
    setState(() {
      _isFavorited = user.isFavorited.returnIsFavorited(_isFavorited);
    });
  }
}
