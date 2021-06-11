import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/core/utils/colors.dart';
import 'package:mobile_challenge/app/core/utils/constants.dart';
import 'package:mobile_challenge/app/core/utils/constrains.dart';
import 'package:mobile_challenge/app/core/utils/fonts.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/user_detail_controller.dart';
import 'package:mobile_challenge/app/modules/users/presentation/widgets/user_detail_item.widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState
    extends ModularState<UserDetailPage, UserDetailController> {
  @override
  void initState() {
    AppController _appcontroller = Modular.get();
    if (_appcontroller.payload is UserEntity) {
      controller.isLocal = true;
      controller.changeUser(_appcontroller.payload);
    } else {
      controller.isLocal = false;
      controller.id = _appcontroller.payload;
      controller.getUser();
    }
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
        Container(
          width: Constrains.layoutSpace(LayoutSpace.xl),
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Constrains.layoutSpace(LayoutSpace.m),
            vertical: Constrains.layoutSpace(LayoutSpace.s),
          ),
          alignment: Alignment.center,
          child: Observer(builder: (_) {
            return Text(
              controller.user?.login ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.fontSize(FontsSize.section)),
            );
          }),
        )),
        SizedBox(
          width: Constrains.layoutSpace(LayoutSpace.xl),
        )
      ]),
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
                      child: ListView(children: [
                        SizedBox(
                            height: Constrains.layoutSpace(LayoutSpace.xxs)),
                        UserDetailItem(
                          avatarUrl: controller.user.avatarUrl,
                          bio: controller.user.bio,
                          email: controller.user.email,
                          location: controller.user.location,
                          login: controller.user.login,
                        ),
                        SizedBox(
                            height: Constrains.layoutSpace(LayoutSpace.xxs)),
                        controller.isLocal
                            ? _buttonPage(
                                color: ColorSystem.secondary,
                                title: Constants.REMOVE_FAVORITE_BUTTON,
                                onTap: () {
                                  controller.removeFavoriteUser(context);
                                })
                            : _buttonPage(
                                color: ColorSystem.primary,
                                title: Constants.ADD_FAVORITE_BUTTON,
                                onTap: () {
                                  controller.doFavoriteUser(context);
                                }),
                        SizedBox(
                            height: Constrains.layoutSpace(LayoutSpace.xxs)),
                      ])));
    });
  }

  Widget _buttonPage({String title, Function onTap, Color color}) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: Constrains.layoutSpace(LayoutSpace.xs)),
          child: Card(
              color: color,
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Constrains.layoutSpace(LayoutSpace.s)),
                  child: Center(
                      child: Text(
                    title,
                    style: TextStyle(
                        color: ColorSystem.white, fontWeight: FontWeight.bold),
                  )))),
        ));
  }

  Widget _errorPage() {
    return Expanded(
        child: Center(
            child: InkWell(
                onTap: () {
                  controller.getUser();
                },
                child: Text(
                  Constants.TRY_AGAIN_BUTTON,
                  style: TextStyle(color: ColorSystem.primary),
                ))));
  }
}
