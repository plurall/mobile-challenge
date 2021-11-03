import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import 'package:mobile_challenge/controllers/search_controller.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/models/search_model.dart';
import 'package:mobile_challenge/services/app_service.dart';
import 'package:mobile_challenge/views/widgets/searchbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.get<AppService>().saveToStorage();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.none) {
        Modular.to.pushNamed('favorites');
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return Drawer(
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
          onTap: () => Modular.to.pushNamed('/favorites'),
          leading: Icon(Icons.favorite),
          title: Text('Usuários favoritos'),
        )
      ],
    ));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: SearchBar(
        controller: context.read<SearchController>().inputController,
      ),
      actions: [
        IconButton(
            onPressed: () => Modular.to.pushNamed('/favorites'),
            icon: Icon(Icons.favorite))
      ],
    );
  }

  Widget _body() {
    var status = context.watch<SearchController>().status;

    switch (status) {
      case Status.fetching:
        return _loadingContainer();
      case Status.fetched:
        return _listAllUsers();
      case Status.failure:
        return _errorContainer();
      default:
        return _idleContainer();
    }
  }

  Widget _idleContainer() {
    return Center(
      child: Text('Pesquise os usuários do Github'),
    );
  }

  Widget _loadingContainer() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _listAllUsers() {
    bool hasUsers = context.watch<SearchController>().result.totalCount > 0;
    var controller = context.watch<SearchController>();
    return hasUsers
        ? PagedListView<int, User>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<User>(
                itemBuilder: (context, user, index) {
              return ListTile(
                onTap: () => Modular.to.pushNamed('/user/${user.login}'),
                leading: CircleAvatar(child: Image.network(user.avatarUrl)),
                title: Text(user.login),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              );
            }),
          )
        : Center(
            child: Text('Nenhum usuário encontrado com esta pesquisa.'),
          );
  }

  Widget _errorContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text('Ocorreu um problema ao buscar os usuários')),
        SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                String query = context.read<SearchController>().query;
                context.read<SearchController>().fetchUsers(query);
              },
              child: Row(
                children: [Icon(Icons.refresh), Text('Tentar novamente')],
              )),
        )
      ],
    );
  }
}
