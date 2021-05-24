import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api/controller/githubController.dart';
import 'package:github_api/utils/routes.dart';
import 'package:http/http.dart' as http;

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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                onSubmitted: (value) => controller.fetchProfileUser(
                  http.Client(),
                  value,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Icon(Icons.search),
                ),
                controller: controller.search,
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
              ),
              itemCount: controller.listProfiles.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(179, 24, 97, 1.0),
                      Color.fromRGBO(159, 26, 116, 1.0),
                      Color.fromRGBO(146, 28, 131, 1.0),
                      Color.fromRGBO(122, 29, 153, 1.0),
                    ]),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, -3),
                        color: Colors.white,
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        offset: Offset(2, 2),
                        color: Colors.grey[500]!,
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
