import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_block.dart';
import 'package:mobile_challenge/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBlock>();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(left: 8.0,top: 8.0,right: 8.0),
          child: TextField(
            onChanged: bloc.add,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Buscar ...'
            ),
          ),),

          Expanded(
              child:
                  StreamBuilder(
                    stream: bloc,
                    builder: (context,snapshot){
                      final state = bloc.state;
                      if(state is SearchStart){
                        return Center(
                          child: Text('Digite o nome'),
                        );
                      }
                      if(state is SearchError){
                        return Center(
                          child: Text('Ocorreu um erro'),
                        );
                      }
                      if(state is SearchLoading){
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      }

                      final list = (state as SearchSucces).list;


                      return  ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_,id){
                            final item = list[id];

                           return GestureDetector(
                                onTap: (){
                                  Modular.to.pushNamed('/perfil/'+item.login ?? "");
                                },
                                child:
                             ListTile(
                              leading: item.avatar_url ==null ? Container() :CircleAvatar(
                                backgroundImage: NetworkImage(item.avatar_url),
                              ),
                              title: Text(item.login ?? ""),
                              subtitle: Text(item.id.toString() ?? ""),

                            )
                            );

                          }
                      );


                    } ,
                  ),









          )

        ],
      ),
    );
  }
}
