import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/presentation/components/user_info.dart';
import 'package:mobile_challenge/presentation/components/user_profile_picture.dart';

class UserFullProfile extends StatelessWidget {
  final User? user;

  UserFullProfile(this.user);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
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
      ),
    );
  }
}
