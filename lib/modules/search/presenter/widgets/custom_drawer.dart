import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/search/infra/models/mensagens.dart';


class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _builderDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 59, 109, 239),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _builderDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 190.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16.0,
                      left: 0.0,
                      child: Text("Desafio\nPlurall",
                      style: TextStyle(
                        fontSize: 44.0, fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bem vindo!",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Mensagens mensagem = Mensagens();
                              mensagem.mensagemExibicao();
                            },
                            child: Text("Entre ou cadastre-se",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                        ),
                    ),
                  ],
                ),
              ),
              Divider(),
             ListTile(
               leading: Icon(Icons.perm_identity,),
               title: Text("Meu Perfil",
               style: TextStyle(
                 fontSize: 18
               ),
               ),
               onTap: () {
                 Navigator.pushNamed(context, "/PagePerfil");
               },
             ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Favoritos",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, "/PageFavoritos");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
