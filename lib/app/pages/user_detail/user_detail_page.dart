import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/model/result_search.dart';
import 'package:mobile_challenge/app/pages/search/search_module.dart';
import 'package:mobile_challenge/app/pages/user_detail/user_detail_page_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailPage extends StatefulWidget {
  Items? item;
  UserDetailPage({this.item});

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool _star = false;
  List<String>? listIdsUser;
  bool screenOk = false;
  var args;

  late UserDetailPageBlock bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as UserDetailPage;
    _getListStarredSaved();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  // }

  _getListStarredSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listIdsUser = prefs.getStringList('listStarred') ?? [];

    setState(() {
      screenOk = true;
      _star = listIdsUser!.contains(args.item!.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (screenOk) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do usuário'),
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() => {_star = !this._star});
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (this._star) {
                    listIdsUser!.add(args.item!.id.toString());
                  } else {
                    // listIdsUser!.remove(args.item!.id.toString());
                    listIdsUser!.clear();
                  }
                  prefs.setStringList("listStarred", listIdsUser!);
                },
                icon: Icon(
                  Icons.star_rate,
                  color: _star ? Colors.yellow : Colors.grey,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 120,
            child: Container(
              height: 120,
              child: Row(
                children: [
                  Image.network(args.item!.avatarUrl!),
                  Container(
                    height: 120,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Nome Usuário: ${args.item!.login}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Tipo do Usuário: ${args.item!.type}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Score: ${args.item!.score}'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do usuário'),
          actions: [
            IconButton(
                onPressed: () => {
                      setState(() => {_star = !this._star})
                    },
                icon: Icon(
                  Icons.star_rate,
                  color: _star ? Colors.yellow : Colors.grey,
                ))
          ],
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
