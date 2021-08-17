import 'package:mobile_challenge/app/views/favorite/components/body.dart';
import 'package:mobile_challenge/app/helpers/favorite_helper.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  var _db = FavoriteHelper();
  List _favorites = List();

  Future<void> _getFavorites() async {
    List favorites = await _db.getFavorites();
    setState(() {
      _favorites = favorites.toList();
    });
  }

  void _removeFavorite(int id) async {
    int res = await _db.removeFavorite(id);
    if (res > 0)
      Toast.show('Removido', context, duration: 3, gravity: Toast.TOP);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Center(
          child: Text(
            ' FAVORITOS',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body:
      _favorites == null
          ? Center(
        child: Text(''),
      )
          : RefreshIndicator(
        onRefresh: () async {
          _getFavorites();
        },
        child: Body(_favorites,_removeFavorite),
      ),
    );
  }
}
