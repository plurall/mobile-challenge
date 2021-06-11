import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/core/utils/colors.dart';
import 'package:mobile_challenge/app/core/utils/constants.dart';
import 'package:mobile_challenge/app/core/utils/constrains.dart';
import 'package:mobile_challenge/app/core/utils/fonts.dart';
import 'package:mobile_challenge/app/core/utils/routes.dart';
import 'package:mobile_challenge/app/modules/favorites/presentation/controllers/favorites_controller.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/presentation/widgets/user_item.widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState
    extends ModularState<FavoritesPage, FavoritesController> {
  @override
  void initState() {
    controller.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Column(children: [_headerPage(), _bodyPage()])));
  }

  Widget _headerPage() {
    return Column(children: [
      Row(children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Constrains.layoutSpace(LayoutSpace.m),
            vertical: Constrains.layoutSpace(LayoutSpace.s),
          ),
          alignment: Alignment.topLeft,
          child: Text(
            Constants.FAVORITES_TITLE,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Fonts.fontSize(FontsSize.page)),
          ),
        )),
      ]),
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: Constrains.layoutSpace(
          LayoutSpace.s,
        )),
      )
    ]);
  }

  Widget _bodyPage() {
    return Observer(builder: (_) {
      return controller.isError
          ? _errorPage()
          : controller.isLoading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Container(
                      width: Constrains.fullWidth(context),
                      color: ColorSystem.backgroundPage,
                      child: controller.users.length == 0
                          ? Center(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Constrains.layoutSpace(
                                          LayoutSpace.m)),
                                  child: Text(Constants.USERS_NOT_FOUND)),
                            )
                          : ListView(
                              children: [
                                ...controller.users.map((UserEntity model) {
                                  return UserItem(
                                    avatarUrl: model.avatarUrl,
                                    login: model.login,
                                    onTap: () {
                                      AppController userDetailController =
                                          Modular.get();
                                      userDetailController.payload = model;
                                      Navigator.pushNamed(
                                              context, Routes.USERS_DETAIL)
                                          .then((value) =>
                                              {controller.getFavorites()});
                                    },
                                  );
                                }).toList(),
                                SizedBox(
                                    height: Constrains.layoutSpace(
                                        LayoutSpace.xxs)),
                              ],
                            )));
    });
  }

  Widget _errorPage() {
    return Expanded(
        child: Center(
            child: InkWell(
                onTap: () {
                  controller.getFavorites();
                },
                child: Text(
                  Constants.TRY_AGAIN_BUTTON,
                  style: TextStyle(color: ColorSystem.primary),
                ))));
  }
}
