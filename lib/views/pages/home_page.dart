import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobile_challenge/controllers/search_controller.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/models/search_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Github App'),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Pesquisar'),
          )
        ],
      )),
      appBar: AppBar(
        title: Text('Github'),
        actions: [
          ElevatedButton(
              onPressed: () {
                context.read<SearchController>().fetchUser('teste');
              },
              child: Text('Cliquie aqui'))
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    var status = context.watch<SearchController>().status;
    var controller = context.watch<SearchController>();
    if (status == Status.fetching) {
      return Center(child: CircularProgressIndicator());
    } else if (status == Status.fetched) {
      if (controller.result.totalCount > 0) {
        return PagedListView<int, User>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (context, user, index) {
            return ListTile(
              leading: CircleAvatar(child: Image.network(user.avatarUrl)),
              title: Text(user.login),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            );
          }),
        );
      } else {
        return Center(child: Text('Nenhum resultado encontrado.'));
      }
    } else {
      return Center(
        child: Text('Pesquise os usuários do Github'),
      );
    }
  }
}
