import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/modules/user_info/user_info_controller.dart';
import 'package:mobile_challenge/app/modules/user_info/widgets/card_skeleton.dart';
import 'package:mobile_challenge/app/modules/user_info/widgets/card_user.dart';
import 'package:mobile_challenge/app/modules/global_widgets/empty_message.dart';

class UserInfoPage extends GetView<UserInfoController> {
  static final route = '/info';

  static String buildArguments({@required String username}) => username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          child: Obx(
            () {
              if (controller.isSearching) {
                return LoaderSkeleton();
              }
              if (controller.user != null) {
                return CardUser(
                  user: controller.user,
                  onPressed: controller.onPressFavorite,
                  buttonText: controller.isFavorite
                      ? 'Remover dos favoritos'
                      : 'Adicionar nos favoritos',
                );
              }
              return EmptyMessage(
                text: 'Ops... Ocorreu um erro',
              );
            },
          ),
        ),
      ),
    );
  }
}
