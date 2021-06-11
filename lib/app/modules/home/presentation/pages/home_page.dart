import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/favorites/presentation/pages/favorites.page.dart';
import 'package:mobile_challenge/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:mobile_challenge/app/modules/users/presentation/pages/users.page.dart';
import 'package:mobile_challenge/app/shared/utils/colors.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: false,
            child: Stack(children: [
              DefaultTabController(
                  length: 2,
                  initialIndex: index,
                  child: Scaffold(
                      backgroundColor: Colors.white,
                      bottomNavigationBar: Container(
                          child: TabBar(
                        isScrollable: false,
                        onTap: (indexTab) {
                          setState(() {
                            index = indexTab;
                          });
                        },
                        labelStyle: TextStyle(fontSize: 12),
                        labelPadding: EdgeInsets.only(bottom: 5),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.group, size: 30),
                          ),
                          Tab(
                            icon: Icon(Icons.star, size: 30),
                          ),
                        ],
                        labelColor: ColorSystem.primary,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                      )),
                      body: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          UsersPage(),
                          FavoritesPage(),
                        ],
                      )))
            ])));
  }
}
