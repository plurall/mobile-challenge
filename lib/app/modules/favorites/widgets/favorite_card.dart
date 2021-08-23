import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/models/user_model.dart';
import 'package:mobile_challenge/app/modules/global_widgets/photo_user.dart';
import 'package:mobile_challenge/app/modules/user_info/user_info_page.dart';

class FavoriteCard extends StatelessWidget {
  FavoriteCard({@required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Get.toNamed(
          UserInfoPage.route,
          arguments: UserInfoPage.buildArguments(
            username: user.login,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhotoUser(
            url: user.avatarUrl,
          ),
        ),
      ),
    );
  }
}
