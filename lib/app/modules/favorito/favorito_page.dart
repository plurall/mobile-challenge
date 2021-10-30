import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/favorito/controller/favorito_controller.dart';
import 'package:mobile_challenge/app/shared/database/favorito_cache.dart';
import 'package:mobile_challenge/app/shared/model/user_details_model.dart';
import 'package:mobile_challenge/app/shared/widgets/card_favorito_widget.dart';

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
              return CardFavoritoWidget(dados[index]);
            },
          );
        }
      ),
    );
  }
}