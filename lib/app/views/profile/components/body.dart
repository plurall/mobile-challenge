import 'package:mobile_challenge/app/views/profile/components/favorite_button.dart';
import 'package:mobile_challenge/app/views/profile/components/profile_image.dart';
import 'package:mobile_challenge/app/views/profile/components/cover_image.dart';
import 'package:mobile_challenge/app/views/profile/components/profile_bio.dart';
import 'package:mobile_challenge/app/services/profile_service.dart';
import 'package:mobile_challenge/app/models/profile_model.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  ProfileModel profileModel;
  final BuildContext context;
  final Function(ProfileModel value) saveFavorite;
  final String login;
  final String avatar;

  Body(this.profileModel,this.saveFavorite,this.context,this.login,this.avatar);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<dynamic>(
        future: ProfileService().getProfile(this.widget.login),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            this.widget.profileModel = snapshot.data;
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
                  child:
                  Stack(
                    children: <Widget>[
                      CoverImage(),
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              FavoriteButton(this.widget.profileModel,this.widget.saveFavorite),
                              ProfileImage(this.widget.avatar ?? ""),
                              ProfileBio(
                                  this.widget.login,
                                  snapshot.data.name ?? "Não informado",
                                  snapshot.data.email ?? "Não informado",
                                  snapshot.data.bio ?? "Não informado",
                                  snapshot.data.location ?? "Não informado"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 0.5,
                color: Colors.white,
              ),
              itemCount: 1, // snapshot.data.length //snapshot.data.length
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
