import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/controller/user_detail_controller.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  UserEntity? userEntity;
  late UserDetailController _controller;

  @override
  void initState() {
    _controller = GetIt.instance<UserDetailController>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchUserDetail(String value) async {
    await _controller.userDetail(value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;

    userEntity = ModalRoute.of(context)?.settings.arguments as UserEntity;
    _fetchUserDetail(userEntity!.url);

    return Scaffold(
      appBar: AppBar(
        title: Text(userEntity!.login ?? ''),
      ),
      body: Observer(
        builder: (_) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: availableHeight * 0.50,
                  width: double.infinity,
                  child: Image.network(
                    userEntity!.avatarUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  _controller.userEntity!.location ?? '',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(_controller.userEntity!.bio ?? ''),
                SizedBox(
                  height: 10.0,
                ),
                Text(_controller.userEntity!.name ?? ''),
                SizedBox(
                  height: 10.0,
                ),
                Text(_controller.userEntity!.email ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
