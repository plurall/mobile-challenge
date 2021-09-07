import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';

class CustomListTile extends StatefulWidget {
  final ResultSearch userSearch;
  final UserResultSearchModel user;

  const CustomListTile({
    Key key,
    this.userSearch,
    this.user,
  }) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {

  String _avatar;
  String _login;
  var _argument;
  int _imgNumber;

  _setUser(){
    if(this.widget.userSearch != null){
      setState(() {
        _avatar = this.widget.userSearch.avatar;
        _login = this.widget.userSearch.title;
        _argument = [this.widget.userSearch, null];
      });
    } else {
      setState(() {
        _avatar = this.widget.user.avatar ?? '';
        _login = this.widget.user.login ?? '';
        _argument = [null, this.widget.user];
      });
    }
    var random = new Random();
    setState(() {
      _imgNumber = random.nextInt(3);
    });
  }

  @override
  void initState() {
    _setUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: GestureDetector(
          onTap: (){
            Modular.to.pushNamed("/user-details",
                arguments: _argument,
            );
          },
          child: ListTile(
            leading: ClipOval(
              child: FadeInImage(
                      placeholder: AssetImage(
                          'assets/images/avatar_$_imgNumber.png'),
                      imageErrorBuilder: (context, _, s){
                        return Image.asset(
                            'assets/images/avatar_$_imgNumber.png');
                      },
                      image: NetworkImage(_avatar),
                      height: 120,
                    ),
            ),
            title: Text(_login ?? '', style: TextStyle(
              color: Colors.black,
              fontSize: 20
            ),),
          ),
        ),
      ),
    );
  }
}


