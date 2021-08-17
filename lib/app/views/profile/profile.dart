import 'package:mobile_challenge/app/views/profile/components/body.dart';
import 'package:mobile_challenge/app/helpers/favorite_helper.dart';
import 'package:mobile_challenge/app/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  String login;
  String avatar;
  Profile(this.login, this.avatar);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var _db = FavoriteHelper();
  ProfileModel _perfilModel;
  String _message;

  Future<void> _saveFavorite(ProfileModel perfilModel) async {
    try {
      int id = await _db.saveFavorite(perfilModel);
      id > 0 ? _message='Favoritado' : 'Não Favoritado';
    } catch (e) {
      throw Exception('Erro ao inserir usuário como favorito');
    }
    Toast.show(_message, context,duration: 3, gravity: Toast.TOP);
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil ' + this.widget.login,
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.amberAccent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:Body(_perfilModel,_saveFavorite,context,this.widget.login,this.widget.avatar),
    );
  }
}
