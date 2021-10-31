import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/favorito/presenter/favorito/favorito_page.dart';
import 'package:mobile_challenge/app/modules/home/external/datasource/home_request_data.dart';
import 'package:mobile_challenge/app/modules/home/external/drives/connectivity_driver.dart';
import 'package:mobile_challenge/app/modules/home/presenter/pages/home/home_controller.dart';
import 'package:mobile_challenge/app/modules/home/presenter/pages/seach/seach_page.dart';
import 'package:mobile_challenge/app/shared/domain/Entities/user_model.dart';
import 'package:mobile_challenge/app/shared/domain/errors/message_exception.dart';
import 'package:mobile_challenge/app/modules/home/presenter/widgets/card_users_widget.dart';
import 'package:mobile_challenge/app/shared/util/dio_options.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _controller = HomeController(
    homeService: HomeService(Dio(dioOption)),
    connectivityDriver: ConnectivityDriver()
  );
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    getUsers();
    validOnlineAndOffline();
    _controller.connectivityDriver.connectivitySubscription = 
      _controller.connectivityDriver.connectivity.onConnectivityChanged.listen(_updateConnectionStatus)..onDone(() {getUsers();});
  }

  validOnlineAndOffline() async {
   ConnectivityResult result =  await _controller.initConnectivity();
   _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus);
    });
  }

  getUsers() async {
    try {
      await _controller.getUsers();
    } on MessageException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Somos educação \nTeste técnico (Github API)',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                )
              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SeachPage())
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                      prefixIcon: Icon(Icons.search)
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Text(
                'Users',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<Users>>(
                  stream: _controller.userOut,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (_connectionStatus == ConnectivityResult.none){
                      return Center(
                        child: Text('Você está em modo offline, acesse os favoritos'),
                      );              
                    }
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            Text('Erro ao carregar dados'),
                            SizedBox(
                              height: 10,
                            ),
                            CupertinoButton(
                              child: Text('Tente novamente'), 
                              onPressed: () => getUsers()
                            ),
                          ],
                        ),
                      );
                    }
                    List<Users> dados = snapshot.data;

                    return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: dados.length,
                      itemBuilder: (context,index){
                        return CardUsersWidget(
                          model: dados[index],
                        );
                      }
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => FavoritoPage())
          );
        }, 
        label: Text('Favoritos')
      ),
    );
  }
}