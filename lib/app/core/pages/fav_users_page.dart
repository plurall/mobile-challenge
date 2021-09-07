import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localstore/localstore.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_search_store.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/widgets/custom_list_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavUsersPage extends StatefulWidget {
  const FavUsersPage({Key key}) : super(key: key);

  @override
  _FavUsersPageState createState() => _FavUsersPageState();
}

class _FavUsersPageState extends ModularState<FavUsersPage, UserSearchStore> {

  final db = Localstore.instance;
  ScrollController _listController = ScrollController();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    _listController.jumpTo(_listController.position.maxScrollExtent);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Observer(
            builder: (_){
              controller.getUserStream();
              return Stack(
                children: [
                  StreamBuilder(
                    stream: controller.userStream,
                    builder: (context, snapshot){
                      print(snapshot.connectionState);
                      final items = snapshot.data != null
                          ? Map<String, dynamic>.from(snapshot.data)
                          : Map<String, dynamic>();
                      final list = [];
                      items.forEach((key, value) {
                        list.add(UserResultSearchModel.fromMap(value));
                      });
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(color: Colors.black,),
                        );
                      }

                      if(snapshot.connectionState == ConnectionState.done){
                        return list.length > 0 ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 116),
                            child: SmartRefresher(
                              enablePullDown: true,
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              header: WaterDropHeader(),
                              child: ListView.builder(
                                  itemCount: list.length,
                                  controller: _listController,
                                  itemBuilder: (context, index){
                                    return CustomListTile(
                                        user: list[index],
                                    );
                                  }
                              ),
                            ),
                          ),
                        ) : Center(
                          child: Text('Ainda não tem favoritos \n'
                              'Pesquise na barra acima...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Raleway"
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
