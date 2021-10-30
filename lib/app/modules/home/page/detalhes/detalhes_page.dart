import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/home/controller/home_controller.dart';
import 'package:mobile_challenge/app/modules/home/service/home_service.dart';
import 'package:mobile_challenge/app/shared/database/favorito_cache.dart';
import 'package:mobile_challenge/app/shared/exception/message_exception.dart';
import 'package:mobile_challenge/app/shared/model/user_details_model.dart';
import 'package:mobile_challenge/app/shared/model/user_model.dart';

class DetalhesPage extends StatefulWidget {
  final Users model;
  DetalhesPage(this.model);

  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {

  HomeController _controller = HomeController(homeService: HomeService());
  FavoritoCacheDb _favoritoCacheDb = FavoritoCacheDb();


  @override
  void initState() {
    super.initState();
    getUserSingle();
  }

  getUserSingle() async {
    try {
      await _controller.getUserSingel(widget.model.login);
    } on MessageException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  favoritarUser(UserSingle user) async {
    try {
      await _favoritoCacheDb.saveFavorito(user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User salvo'),
          backgroundColor: Colors.blue,
        )
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar')));
    }
  }

  @override
  void dispose() {
    _controller.userSingleController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        centerTitle: true
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Hero(
              tag: widget.model.login,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(widget.model.avatarUrl),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<UserSingle>(
              stream: _controller.userSingleOut,
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text('Erro ao carregar dados'),
                        SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                          child: Text('Tente novamente'), 
                          onPressed: () => getUserSingle()
                        ),
                      ],
                    ),
                  );
                }
                UserSingle dados = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text('Nickname: ${dados.name == null ? 'Nickname indisponível' : dados.name}'),
                      Text('Localização: ${dados.location == null ? 'Localização indisponível' : dados.location }'),
                      Text('Bio: ${dados.bio == null ? 'Bio indisponível' : dados.bio }'),
                      Text('E-mail: ${dados.email == null ? 'E-mail indisponível' : dados.email}'),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10
                        ),
                        child: CupertinoButton(
                          child: Text('Favoritar user'), 
                          color: Colors.blue,
                          onPressed: () => favoritarUser(dados)
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}