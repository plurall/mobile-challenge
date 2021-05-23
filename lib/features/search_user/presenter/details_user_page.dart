import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/user_detail/user_detail_store.dart';

class DetailsUserPage extends StatefulWidget {
  final String username;

  const DetailsUserPage({Key? key, required this.username}) : super(key: key);
  @override
  _DetailsUserPageState createState() => _DetailsUserPageState();
}

class _DetailsUserPageState
    extends ModularState<DetailsUserPage, UserDetailStore> {
  @override
  void initState() {
    controller.showDetailUser(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do usuário"),
        brightness: Brightness.dark,
      ),
      body: Column(),
    );
  }
}
