import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/presenter/search_user_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, SearchUserStore> {
  final _controller = TextEditingController();

  Widget _buildList(List<UserEntity> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(item.nickname),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pesquise...",
              ),
              onSubmitted: (a) {
                controller.makeSearch(a);
              },
            ),
          ),
          Expanded(child: Observer(builder: (_) {
            var user = controller.users;
            return _buildList(user);
          }))
        ],
      ),
    );
  }
}
