import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api/controller/githubController.dart';
import 'package:github_api/utils/widgets.dart';

class ProfileGithub extends GetView<GithubController> {
  final bool isFromDatabase;

  ProfileGithub({this.isFromDatabase = false});
  @override
  Widget build(BuildContext context) {
    final profile = controller.githubProfile;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(179, 24, 97, 1.0),
                    Color.fromRGBO(159, 26, 116, 1.0),
                    Color.fromRGBO(146, 28, 131, 1.0),
                    Color.fromRGBO(122, 29, 153, 1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: MediaQuery.of(context).size.height / 3,
              width: double.maxFinite,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: isFromDatabase
                      ? Icon(
                          Icons.error_outline,
                          color: Colors.white.withOpacity(0.9),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(profile!.avatarUrl.toString()),
                          radius: 55,
                        ),
                ),
              ),
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: (MediaQuery.of(context).size.height / 3) * 2 + 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textField(
                              profile!.login, Icon(Icons.person), 'LOGIN'),
                          textField(profile.email, Icon(Icons.email), 'E-MAIL'),
                          textField(profile.nickname, Icon(Icons.person_pin),
                              'NICKNAME'),
                          textField(profile.avatarUrl, Icon(Icons.link),
                              'AVATAR_URL'),
                          textField(profile.bio, Icon(Icons.book), 'BIO'),
                          textField(profile.location, Icon(Icons.location_on),
                              'LOCALIZAÇÃO'),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
