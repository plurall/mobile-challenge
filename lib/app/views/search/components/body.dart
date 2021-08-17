import 'package:mobile_challenge/app/services/search_service.dart';
import 'package:mobile_challenge/app/views/profile/profile.dart';
import 'package:mobile_challenge/app/models/search_model.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  TextEditingController searchController;
  Body(this.searchController);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<SearchModel>>(
          future: SearchService().search(this.searchController.text),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Pronto ...');
                case ConnectionState.waiting:
                  return Text('Buscando ...');
                case ConnectionState.active:
                  return Text('Ativo ...');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, id) {
                        final item = snapshot.data[id];
                        return Column(children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(item.login),
                                  subtitle: Text(item.id.toString()),
                                  trailing: Text(
                                    item.id.toString(),
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                    NetworkImage(item.avatar_url + '.png'),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  indent: 39,
                                  endIndent: 28,
                                  height: 10,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Profile(
                                          item.login, item.avatar_url)));
                            },
                          ), //),
                        ]);
                      },
                    );
                  }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
