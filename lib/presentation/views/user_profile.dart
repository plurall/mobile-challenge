import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de ${user.login}'),
      ),
      body: Container(
        child: Text(user.login),
      ),
    );
  }
}
