import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/app.module.dart';
import 'package:mobile_challenge/app/app_bloc.dart';
import 'package:mobile_challenge/model/result_search.dart';
import 'package:mobile_challenge/pages/search_module.dart';
import 'package:mobile_challenge/pages/search_page_bloc.dart';
import 'package:mobile_challenge/components/search.dart';

class SearchPage extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Texto $index");
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching = false;
  SearchPageBlock bloc;
  final _textSearch = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = SearchModule.to.bloc<SearchPageBlock>();
    bloc.getListUsers('Withi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !isSearching
              ? Text("Pesquisa")
              : TextFormField(
                  controller: _textSearch,
                  onFieldSubmitted: (value) => {bloc.getListUsers(value)},
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Procure pelo do usuário",
                      icon: GestureDetector(
                          onTap: () =>
                              setState(() => isSearching = !this.isSearching),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        onPressed: () => {_textSearch.clear()},
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      )),
                ),
          actions: !isSearching
              ? [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => {
                            setState(() {
                              isSearching = !this.isSearching;
                            })
                          }),
                  Switch(
                      value: AppModule.to.bloc<AppBloc>().isDark,
                      onChanged: (value) =>
                          {AppModule.to.bloc<AppBloc>().changeTheme()})
                ]
              : [
                  Switch(
                      value: AppModule.to.bloc<AppBloc>().isDark,
                      onChanged: (value) =>
                          {AppModule.to.bloc<AppBloc>().changeTheme()})
                ]),
      body: StreamBuilder<List<Items>>(
          stream: bloc.resultOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.data.length > 0) {
              return Container(
                color: Colors.black12,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            print('TESTE ' + snapshot.data[index].toString());
                          },
                          child: Card(
                              margin: EdgeInsets.all(5),
                              child: ListTile(
                                  title: Text(snapshot.data[index].login),
                                  subtitle: Text(snapshot.data[index].url),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data[index].avatarUrl),
                                  ),
                                  trailing: Icon(Icons.star))),
                        )),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Pesquisa"),
  //       actions: [
  //         StreamBuilder<List<Items>>(
  //             stream: bloc.resultOut,
  //             builder: (context, snapshot) {
  //               return IconButton(
  //                   icon: Icon(Icons.search),
  //                   onPressed: () => {
  //                         showSearch(
  //                             context: context, delegate: Search(snapshot.data))
  //                       });
  //             }),
  //         Switch(
  //             value: AppModule.to.bloc<AppBloc>().isDark,
  //             onChanged: (value) =>
  //                 {AppModule.to.bloc<AppBloc>().changeTheme()})
  //       ],
  //     ),
  //     body: StreamBuilder<List<Items>>(
  //         stream: bloc.resultOut,
  //         builder: (context, snapshot) {
  //           if (snapshot.hasError) {
  //             return Center(child: Text(snapshot.error.toString()));
  //           }

  //           if (snapshot.hasData) {
  //             return ListView.builder(
  //                 itemCount: snapshot.data.length,
  //                 itemBuilder: (context, index) => Card(
  //                     child: ListTile(
  //                         title: Text(snapshot.data[index].login),
  //                         subtitle: Text(snapshot.data[index].url),
  //                         leading: CircleAvatar(
  //                           backgroundImage:
  //                               NetworkImage(snapshot.data[index].avatarUrl),
  //                         ),
  //                         trailing: Icon(Icons.star))));
  //           } else {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //         }),
  //   );
  // }
}
