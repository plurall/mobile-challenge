import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/widgets/custom_list_tile.dart';

class FavUsersPage extends StatefulWidget {
  const FavUsersPage({Key key}) : super(key: key);

  @override
  _FavUsersPageState createState() => _FavUsersPageState();
}

class _FavUsersPageState extends State<FavUsersPage> {

  final db = Localstore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: db.collection("users").get().asStream(),
          builder: (context, snapshot){
            print(snapshot.connectionState);
            final items = snapshot.data != null
                ? Map<String, dynamic>.from(snapshot.data)
                : Map<String, dynamic>();
            final list = items.values.toList();
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(color: Colors.black,),
              );
            }

            if(snapshot.connectionState == ConnectionState.done){
              return Center(
                child: ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: 120),
                    itemBuilder: (context, index){
                      return CustomListTile(
                          avatar: list[index]['avatar'] ?? '',
                          title: list[index]['login'] ?? ''
                      );
                    }
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_sharp),
        onPressed: (){
          setState(() {});
        },
      ),
    );
  }
}
