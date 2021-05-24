import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/search/domain/database/bancoDados.dart';
import 'package:mobile_challenge/modules/search/infra/models/classeJson.dart';
import 'package:mobile_challenge/modules/search/infra/models/mensagens.dart';


class DialogAmostra{

  Mensagens mensagens = Mensagens();
  var _db = FavoritosHelper();

  Future _salvarFavorito( ClassJson favoritoSelecionado ) async {
    await _db.salvarFavorito( favoritoSelecionado );
    mensagens.mensagemFavoritos();
  }

  Future<ClassJson> jsonUsuario;

  abrirDialog(BuildContext context, String url){
    jsonUsuario = jsonUrl(url);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: FutureBuilder<ClassJson>(
                future: jsonUsuario,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  width: 220,
                                  height: 220,
                                  child: Image.network(
                                    snapshot.data.avatarUrl == null ? " " : snapshot.data.avatarUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 8.0)),
                                Text(snapshot.data.login ?? "N/D",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 16.0)),
                                Center(
                                      child: Text("Localização:", style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                ),
                                Padding(padding: EdgeInsets.only(right: 4)),
                                Container(
                                  child: Text(snapshot.data.location ?? "N/D"),
                                ),
                                 Padding(padding: EdgeInsets.only(top: 8.0)),
                                 Center(
                                  child: Text("Bio", style: TextStyle(fontWeight: FontWeight.bold),),
                                 ),
                                 Text(snapshot.data.bio ?? "N/D"),
                                 Padding(padding: EdgeInsets.only(top: 16.0)),
                                 Center(
                                      child: Text("Nickname:", style: TextStyle(fontWeight: FontWeight.bold),),
                                 ),
                                Padding(padding: EdgeInsets.only(right: 4)),
                                Container(
                                        child: Text(snapshot.data.name ?? "N/D"),
                                      ),
                                Padding(padding: EdgeInsets.only(top: 8.0)),
                                Center(
                                  child: Text("E-mail:", style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                      Padding(padding: EdgeInsets.only(right: 4)),
                                      Container(
                                        child: Text(snapshot.data.email ?? "N/D"),
                                      ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Fechar"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: TextButton(
                                          child: Text("Adicionar aos favoritos"),
                                          onPressed: (){

                                            int id = snapshot.data.id;
                                            String login = snapshot.data.login;
                                            String location = snapshot.data.location;
                                            String bio = snapshot.data.bio;
                                            String name = snapshot.data.name;
                                            String email = snapshot.data.email;

                                            ClassJson jsonFavorito = ClassJson(id: id, login:login, location:location, bio:bio, name:name, email:email);
                                            _salvarFavorito(jsonFavorito);

                                          Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]
                          ),
                        )
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
             ),
          );
        }
     );
   }
}
