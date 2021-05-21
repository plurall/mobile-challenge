import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/presentation/stores/user_profile_store.dart';

import '../../../../injection_container.dart';

const kPadding = 24.0;

class UserProfilePage extends StatefulWidget {
  final String username;

  const UserProfilePage({Key key, @required this.username}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final controller = sl<UserProfileStore>();

  @override
  void initState() {
    super.initState();
    controller.getUserInfo(widget.username);
    controller.checkIfUserIsSaved(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: _size.width,
              height: _size.height * 0.35,
              padding: EdgeInsets.only(left: kPadding + 20),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: paddingTop + 20,
            left: kPadding,
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Observer(
            builder: (context) => _getWidgetBasedOnStatus(context, controller),
          ),
        ],
      ),
    );
  }
}

Widget _getWidgetBasedOnStatus(
    BuildContext context, UserProfileStore controller) {
  if (controller.userStatus is Idle) {
    return SizedBox();
  } else if (controller.userStatus is Loading) {
    return Center(child: CircularProgressIndicator());
  } else if (controller.userStatus is Error) {
    return Text(controller.userStatus.props.first);
  }

  final Size _size = MediaQuery.of(context).size;

  return Stack(
    alignment: Alignment.center,
    children: [
      Positioned(
        top: _size.height * 0.28,
        child: Container(
          width: _size.width * 0.92,
          height: 380,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(7, 7),
                spreadRadius: 3,
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 10),
                    Icon(
                      Icons.location_city_rounded,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      controller.userEntity.location,
                    ),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        controller.isSaved
                            ? controller.removeUserFromBookmarks()
                            : controller.saveUser();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              controller.isSaved
                                  ? 'Usuário removido dos favoritos'
                                  : 'Usuário adicionado aos favoritos',
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Icon(
                        controller.isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  controller.userEntity.name ?? controller.userEntity.login,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  controller.userEntity.email ?? 'Email não disponível',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey, thickness: 0.5),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(controller.userEntity.bio ?? 'Nenhuma descrição'),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: _size.height * 0.18,
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(controller.userEntity.avatarUrl),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    ],
  );
}
