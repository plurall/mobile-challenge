import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/models/search_model.dart';
import 'package:mobile_challenge/app/modules/global_widgets/photo_user.dart';
import 'package:mobile_challenge/app/modules/user_info/user_info_page.dart';

class SearchUserCard extends StatelessWidget {
  SearchUserCard({@required this.user});
  final SearchModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Get.toNamed(
          UserInfoPage.route,
          arguments: UserInfoPage.buildArguments(username: user.login),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                height: Get.width * 0.2,
                width: Get.width * 0.2,
                child: PhotoUser(
                  url: user.avatarUrl,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Text(
                  user.login,
                  style: Get.textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
