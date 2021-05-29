import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/features/utils/globals.dart';

import '../../features/controller/github_controller.dart';
import '../../features/controller/global_functions.dart';
import '../../ui/components/app_theme.dart';

class Profile extends GetView<GithubController> {
  final bool isFromDatabase;

  Profile({this.isFromDatabase = false});

  @override
  Widget build(BuildContext context) {
    final profile = controller.githubProfile;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            primaryColorLight,
            primaryColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: mediaQuery(context, 0.3),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: isFromDatabase
                              ? Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                    Icons.error_outline,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                              )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    profile.avatarUrl.toString(),
                                  ),
                                  radius: 55,
                                ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 110,
                    width: double.maxFinite,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: '${profile.login}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mediaQuery(context, 0.05),
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: mediaQuery(context, 0.035),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.email,
                            ),
                          ],
                        ),
                        title: Text(
                          profile.email == null ? noValue : '${profile.email}',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        subtitle: Text(
                          "E-mail",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                            ),
                          ],
                        ),
                        title: Text(
                          profile.nickname == null ? noValue : '${profile.nickname}',
                        ),
                        subtitle: Text(
                          'Nickname',
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.link,
                            ),
                          ],
                        ),
                        title: Text(
                          profile.avatarUrl == null ? noValue : '${profile.avatarUrl}',
                        ),
                        subtitle: Text(
                          'Avatar URL',
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.book,
                            ),
                          ],
                        ),
                        title: Text(
                          profile.bio == null ? noValue : '${profile.bio}',
                        ),
                        subtitle: Text(
                          'BIO',
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                            ),
                          ],
                        ),
                        title: Text(
                          profile.location == null ? noValue : '${profile.location}',
                        ),
                        subtitle: Text(
                          'Localização',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
