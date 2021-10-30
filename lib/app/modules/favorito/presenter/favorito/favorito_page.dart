import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/favorito/presenter/pages/favorito/favorito_controller.dart';
import 'package:mobile_challenge/app/shared/domain/Entities/user_details_model.dart';
import 'package:mobile_challenge/app/shared/infra/datasources/favorito_cache.dart';
import 'package:mobile_challenge/app/modules/favorito/presenter/widgets/card_favorito_widget.dart';

class FavoritoPage extends StatefulWidget {

  @override
  _FavoritoPageState createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {

  FavoritoController _controller = FavoritoController(
    favoritoCacheDb: FavoritoCacheDb()
  );

  @override
  void initState() {
    super.initState();
    getAllFavoritos();
  }

  getAllFavoritos() async {
    try {
      await _controller.getAllFavoritos();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar dados')));
    }
  }

  deletarFavorito(UserSingle user) async {
    try {
      await _controller.deletarFavorito(user);
      setState(() {
        getAllFavoritos();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User tirado dos favoritos'),
            backgroundColor: Colors.blue,
          )
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao deletar user')));
    }  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),

      body: StreamBuilder<List<UserSingle>>(
        stream: _controller.favoritosOut,
        builder: (context, snapshot) {
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
                    onPressed: () => getAllFavoritos()
                  ),
                ],
              ),
            );
          }
          List<UserSingle> dados = snapshot.data;

          if(dados.isEmpty){
            return Center(
              child: Text('Nenhum users favoritado'),
            );
          }
          return ListView.builder(
            itemCount: dados.length,
            itemBuilder: (context,index){
              return CardFavoritoWidget(
                model: dados[index],
                function: () => deletarFavorito(dados[index]),
              );
            },
          );
        }
      ),
    );
  }
}