import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/User.dart';
import 'package:mobile_challenge/models/Users.dart';
import 'package:mobile_challenge/screens/favoriteUser.dart';
import 'package:mobile_challenge/screens/infoUser.dart';
import 'package:mobile_challenge/webApis/getUser.dart';
import 'package:mobile_challenge/webApis/getUsers.dart';
import 'package:mobile_challenge/databases/dbUser.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataBaseHelper db = DataBaseHelper();
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Usuários do Git')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteUser()));
            },
          )
        ],
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
                      color: Colors.blue,
                    ),
                    onTap: () {
                      _adicionandoFavoritosAoBd(user);
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

  void _adicionandoFavoritosAoBd(Users user) async {
    User userParaSalvarNoDb = await GetGitUserAPI.getGitUser(user.login);
    if (_isFavorited == false) {
      try {
        await db.insertUser(userParaSalvarNoDb);
      } catch (e) {
        print(e.runtimeType);
      }

      setState(() {
        _isFavorited = true;
      });

      print("${user.login} ADD");
    } else {
      try {
        await db.deleteUser(userParaSalvarNoDb.id);
      } catch (e) {
        print(e.runtimeType);
      }

      setState(() {
        _isFavorited = false;
      });
      print("${user.login} DELETADO");
    }

    print("Todos os favoritos: ${await db.getAllUsers()}");
  }
}
