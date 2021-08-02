import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_perfil_block.dart';
import 'package:mobile_challenge/modules/search/presenter/search/states/state_perfil.dart';

class SearchPerfilPage extends StatefulWidget {
  final String name;
  SearchPerfilPage({this.name});
  @override
  _SearchPerfilPageState createState() => _SearchPerfilPageState();
}

class _SearchPerfilPageState extends State<SearchPerfilPage> {
  final bloc = Modular.get<SearchPerfilBlock>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(this.widget.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 6.1,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
      ),
    );
  }

  Widget _buildProfileImage(image) {
    return Center(
      child: Container(
        width: 130.0,
        height: 130.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBio(login,name,email,bio,location) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child:
      Stack(
          children: <Widget>[
            Padding(
                padding:EdgeInsets.fromLTRB(2, 0.1,1, 1),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          style: BorderStyle.solid, width: 0.40
                      ),
                    ),
                    child:  Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.green,
                              icon: new Icon(
                                Icons.account_box_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                                child:Text(login)
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.green,
                              icon: new Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                                child:Text(name)
                            )
                          ],
                        ),Divider(),
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.green,
                              icon: new Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                                child:Text(email)
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.green,
                              icon: new Icon(
                                Icons.paste,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                                child:Text(bio)
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.green,
                              icon: new Icon(
                                Icons.place,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                                child:Text(location)
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                )
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil ' + this.widget.name),
      ),
      body:

      Center(
          child:
      StreamBuilder(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchStart) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text('Ocorreu um erro'),
                    );
                  }
                  final list = (state as SearchSucces);
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
                    child: Stack(
                      children: <Widget>[
                        _buildCoverImage(screenSize),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: screenSize.height / 80.4),
                                _buildProfileImage(list.perfil.avatar_url),
                                   _buildBio(this.widget.name,list.perfil.name ?? "Não informado",list.perfil.email ?? "Não informado",list.perfil.bio ??"Não informado",list.perfil.location ??"Não informado"),
                                //  _buildButtons(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),




















//      Column(
//        children: [
//          Expanded(
//            child: GestureDetector(
//              onTap: () {
//                Modular.to.pushNamed('/');
//              },
//              child: StreamBuilder(
//                stream: bloc,
//                builder: (context, snapshot) {
//                  final state = bloc.state;
//
//                  if (state is SearchStart) {
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  }
//
//                  if (state is SearchLoading) {
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  }
//
//                  if (state is SearchError) {
//                    return Center(
//                      child: Text('Ocorreu um erro'),
//                    );
//                  }
//                  final list = (state as SearchSucces);
//                  return ListTile(
//                    leading: list.perfil.avatar_url == null
//                        ? Container()
//                        : CircleAvatar(
//                            backgroundImage:
//                                NetworkImage(list.perfil.avatar_url),
//                          ),
//                    title: Text(list.perfil.name ??
//                        "" "\n" + list.perfil.location ??
//                        ""),
//                    subtitle: Text(
//                        list.perfil.email ?? "" "\n" + list.perfil.bio ?? ""),
//                  );
//                },
//              ),
//            ),
//          )
//        ],
//      ),



    )
    );
  }
}
