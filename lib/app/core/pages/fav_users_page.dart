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
    await Future.delayed(Duration(milliseconds: 500));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                      final reversed = list.reversed.toList();
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(color: Colors.black,),
                        );
                      }

                      if(snapshot.connectionState == ConnectionState.done){
                        return Stack(
                          children: [
                            Visibility(
                              visible: list.length <= 0,
                              child: Center(
                                child: Text('Pesquise na barra acima... \n'
                                    'Após favoritar, deslize para \n '
                                    'baixo para atualizar seus favoritos.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Raleway"
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SmartRefresher(
                                enablePullDown: true,
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                header: WaterDropHeader(),
                                child: ListView.builder(
                                    itemCount: reversed.length,
                                    controller: _listController,
                                    itemBuilder: (context, index){
                                      return CustomListTile(
                                          user: reversed[index],
                                      );
                                    }
                                ),
                              ),
                            ),
                          ],
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
