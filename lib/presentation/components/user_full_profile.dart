import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';
import 'package:mobile_challenge/presentation/components/user_info.dart';
import 'package:mobile_challenge/presentation/components/user_profile_picture.dart';

class UserFullProfile extends StatelessWidget {
  final UserProfile? user;

  UserFullProfile(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserProfilePicture(user!.avatar, user!.login),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserInfo(Icons.account_box, 'Nome', user!.name),
                  UserInfo(Icons.email, 'Email', user!.email),
                  UserInfo(Icons.info, 'Localização', user!.location),
                  UserInfo(Icons.summarize, 'Sobre', user!.bio),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
