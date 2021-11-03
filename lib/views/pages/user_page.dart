import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/controllers/user_controller.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/services/app_service.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  final String id;
  const UserPage({Key key, @required this.id}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  AppService appService = Modular.get<AppService>();
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      initConnectivity();
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
      var controller = Provider.of<UserController>(context, listen: false);
      if (result != ConnectivityResult.none) {
        await controller.fetchUser(widget.id);
      } else {
        await controller.fetchOfflineUser(widget.id);
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    var status = context.watch<UserController>().status;

    if (status == Status.fetching) {
      return Center(child: CircularProgressIndicator());
    } else if (status == Status.fetched) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            SizedBox(height: 20),
            _bio(),
            SizedBox(height: 20),
            _blog(),
            SizedBox(height: 20),
            _location(),
            SizedBox(height: 20),
            _company(),
          ],
        ),
      );
    } else {
      return Center(
          child: Text('Ocorreu um problema para carregar os dados do usuário'));
    }
  }

  Widget _header() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.red,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              context.read<UserController>().userModel.avatarUrl,
              fit: BoxFit.cover,
            ),
          ),
          maxRadius: 42,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              context.read<UserController>().userModel.name ?? widget.id,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              context.read<UserController>().userModel.email,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Consumer<UserController>(builder: (context, controller, child) {
          return IconButton(
            onPressed: () {
              if (controller.isFavorite) {
                controller.removeFromFavorite();
              } else {
                controller.setFavorite();
              }
            },
            icon: Icon(
              controller.isFavorite ? Icons.favorite : Icons.favorite_outline,
            ),
          );
        })
      ],
    );
  }

  Widget _bio() {
    bool hasBio = context.read<UserController>().userModel.bio != null;

    return hasBio
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(context.read<UserController>().userModel.bio),
            ],
          )
        : Container();
  }

  Widget _location() {
    bool hasLocal = context.read<UserController>().userModel.location != null;

    return hasLocal
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Local',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(context.read<UserController>().userModel.location),
            ],
          )
        : Container();
  }

  Widget _company() {
    bool hasCompany = context.read<UserController>().userModel.company != null;

    return hasCompany
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Empresa/Compania',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(context.read<UserController>().userModel.company),
            ],
          )
        : Container();
  }

  Widget _blog() {
    bool hasBlog = context.read<UserController>().userModel.blog != null;

    return hasBlog
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Site',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(context.read<UserController>().userModel.blog),
            ],
          )
        : Container();
  }
}
