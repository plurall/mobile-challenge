import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../features/controller/github_controller.dart';
import '../../features/utils/routes.dart';
import '../components/app_theme.dart';

class SearchPage extends GetView<GithubController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onSubmitted: (value) => controller.fetchProfileUser(
                  http.Client(),
                  value,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
                controller: controller.search,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: ListView.builder(
              itemCount: controller.listProfiles.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        color: Colors.grey[500],
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => {
                      controller.getDetailsOfProfile(index),
                      Get.toNamed(Routes.PROFILE_PAGE),
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            controller.listProfiles.elementAt(index).avatarUrl),
                      ),
                      title: Text(
                        controller.listProfiles
                            .elementAt(index)
                            .login
                            .toUpperCase(),
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      ),
                      trailing: IconButton(
                        onPressed: () => controller.changeFavoriteProfile(
                          index,
                        ),
                        icon: Icon(
                          controller.listProfiles.elementAt(index).favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              controller.listProfiles.elementAt(index).favorite
                                  ? Colors.red
                                  : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
