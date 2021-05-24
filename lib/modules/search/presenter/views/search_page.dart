import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/modules/search/presenter/adapter/itemSearch.dart';
import 'package:mobile_challenge/modules/search/presenter/helper/dialogAmostra.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_bloc.dart';
import 'package:mobile_challenge/modules/search/presenter/search/state.dart';
import 'package:mobile_challenge/modules/search/presenter/widgets/custom_appbar.dart';
import 'package:mobile_challenge/modules/search/presenter/widgets/custom_drawer.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final bloc = Modular.get<SearchBloc>();

@override
  void dispose() {
    super.dispose();
    bloc.close();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search..."
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                stream: bloc,
                builder: (context, snapshot){
                  final state = bloc.state;

                  if(state is SearchStart){
                    return Center(
                      child: Text("Pesquise um usuário"),
                    );
                  }
                  if(state is SearchError){
                    return Center(
                      child: Text("Houve um erro"),
                    );
                  }
                  if(state is SearchLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final list = (state as SearchSuccess).list;

                  return ListView.builder(
                    itemCount: list.length,
                      itemBuilder: (_, id){
                      final item = list[id];
                      return ItemSearch(
                        resultSearch: item,
                        onTapUsuario: (){
                          DialogAmostra amostra = DialogAmostra();
                          amostra.abrirDialog(context, item.url );
                        },
                      );
                    }
                  );
                },
              )
           ),
         ],
       ),
    );
  }
}
