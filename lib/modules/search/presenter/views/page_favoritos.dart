import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/search/domain/database/bancoDados.dart';
import 'package:mobile_challenge/modules/search/infra/models/classeJson.dart';
import 'package:mobile_challenge/modules/search/infra/models/mensagens.dart';
import 'package:mobile_challenge/modules/search/presenter/widgets/custom_appbar.dart';


class PageFavoritos extends StatefulWidget {
  const PageFavoritos({Key key}) : super(key: key);

  @override
  _PageFavoritosState createState() => _PageFavoritosState();
}

List<ClassJson> _favoritos = [];

class _PageFavoritosState extends State<PageFavoritos> {

  @override
  void initState() {
    super.initState();
    _recuperaFavoritos();
  }

  var _db = FavoritosHelper();

  _recuperaFavoritos() async {

    List favoritosRecuperados = await _db.recuperarFavorito();

    List<ClassJson> listaTemporaria = [];
    for( var item in favoritosRecuperados ){

      ClassJson favorito = ClassJson.fromJson( item );
      listaTemporaria.add( favorito );

    }

    setState(() {
      _favoritos = listaTemporaria;
    });

    listaTemporaria = null;
  }

  _alertaDelete(int id) {

    Widget cancelButton = TextButton(
      child: Text("Sim", style: TextStyle(color: Colors.blue),),
      onPressed: () {
        _db.removerFavorito( id );
        _recuperaFavoritos();
        Mensagens mensagens = Mensagens();
        mensagens.mensagemDeletadoFavorito();
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Text("Não", style: TextStyle(color: Colors.blue)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção"),
      content: Text("Tem certeza que deseja apagar esse favorito?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _favoritos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Login: " + _favoritos[index].login,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Localização: ${_favoritos[index].location}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text("Bio: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold
                                    ),),
                                  Text("${_favoritos[index].bio} "),
                                  Text("Nickname: ${_favoritos[index].name}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text("Email: ${_favoritos[index].email}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(8),
                              ),
                              onPressed: (){
                                _alertaDelete(_favoritos[index].id);
                              },
                              child: Icon(Icons.delete, color: Colors.red,),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

