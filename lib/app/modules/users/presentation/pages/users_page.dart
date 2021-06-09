import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mobile_challenge/app/shared/utils/colors.dart';
import 'package:mobile_challenge/app/shared/utils/constrains.dart';
import 'package:mobile_challenge/app/shared/utils/fonts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends ModularState<UsersPage, UsersController> {
  @override
  void initState() {
    controller.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Row(children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Constrains.layoutSpace(LayoutSpace.m),
            vertical: Constrains.layoutSpace(LayoutSpace.s),
          ),
          alignment: Alignment.topLeft,
          child: Text(
            "Usuários",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Fonts.fontSize(FontsSize.page)),
          ),
        )),
      ]),
      Observer(builder: (_) {
        return controller.isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: Container(
                color: ColorSystem.backgroundPage,
              ));
      })
    ])));
  }
}
