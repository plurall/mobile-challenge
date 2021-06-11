import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/core/utils/colors.dart';
import 'package:mobile_challenge/app/core/utils/constants.dart';
import 'package:mobile_challenge/app/core/utils/constrains.dart';
import 'package:mobile_challenge/app/core/utils/fonts.dart';
import 'package:mobile_challenge/app/core/utils/keys.dart';
import 'package:mobile_challenge/app/core/utils/routes.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mobile_challenge/app/modules/users/presentation/widgets/user_item.widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends ModularState<UsersPage, UsersController> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String loadingKey = Keys.LOADING;
  final String loadingBottomKey = Keys.LOADING_BUTTON;
  final String searchButtonKey = Keys.SEARCH_BUTTON;
  final String tryAgainKey = Keys.TRY_AGAIN;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    controller.getUsers();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = 0;
    if (maxScroll - currentScroll == delta && !controller.isLoadingBottom) {
      controller.getUserList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(children: [_headerPage(), _bodyPage()]))));
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
            Constants.USERS_TITLE,
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
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: Constants.LABEL_SEARCH_TEXT_FIELD,
                  prefixIcon: IconButton(
                    onPressed: (null),
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 25,
                    ),
                  )),
            )),
            Container(
                child: OutlinedButton(
              key: Key(searchButtonKey),
              child: Text(Constants.SEARCH_BUTTON),
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.searchValue = _searchController.text;
                controller.getUserListForSearch();
              },
            ))
          ],
        ),
      )
    ]);
  }

  Widget _bodyPage() {
    return Observer(builder: (_) {
      return controller.isError
          ? _errorPage()
          : controller.isLoading
              ? Expanded(
                  child: Center(
                      child: CircularProgressIndicator(key: Key(loadingKey))))
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
                              controller: _scrollController,
                              children: [
                                ...controller.users.map((UserEntity model) {
                                  return UserItem(
                                    avatarUrl: model.avatarUrl,
                                    login: model.login,
                                    onTap: () {
                                      AppController userDetailController =
                                          Modular.get();
                                      userDetailController.payload = model.id;
                                      Navigator.pushNamed(
                                          context, Routes.USERS_DETAIL);
                                    },
                                  );
                                }).toList(),
                                SizedBox(
                                    height: Constrains.layoutSpace(
                                        LayoutSpace.xxs)),
                                _bottomLoading()
                              ],
                            )));
    });
  }

  Widget _errorPage() {
    return Expanded(
        child: Center(
            child: InkWell(
                key: Key(tryAgainKey),
                onTap: () {
                  controller.getUserList();
                },
                child: Text(
                  Constants.TRY_AGAIN_BUTTON,
                  style: TextStyle(color: ColorSystem.primary),
                ))));
  }

  Widget _bottomLoading() {
    return Observer(builder: (_) {
      return controller.isLoadingBottom
          ? Column(
              children: [
                Container(
                    width: 25,
                    height: 25,
                    child: Center(
                        child: CircularProgressIndicator(
                            key: Key(loadingBottomKey)))),
                SizedBox(height: Constrains.layoutSpace(LayoutSpace.xxs)),
              ],
            )
          : Container();
    });
  }
}
