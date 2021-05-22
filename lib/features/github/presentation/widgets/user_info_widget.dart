import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/presentation/stores/user_profile_store.dart';

class UserInfoWidget extends StatelessWidget {
  final UserProfileStore controller;
  const UserInfoWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10),
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
                child: Observer(builder: (_) {
                  return Icon(
                    controller.isSaved
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                  );
                }),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 24),
              Container(
                // width: 120,
                child: Text(
                  controller.userEntity.location ??
                      'Localização não disponível',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail_outline, size: 24),
              SizedBox(width: 10),
              Container(
                child: Text(
                  controller.userEntity.email ?? 'Email não disponível',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(controller.userEntity.bio ?? 'Nenhuma descrição'),
          ),
        ],
      ),
    );
  }
}