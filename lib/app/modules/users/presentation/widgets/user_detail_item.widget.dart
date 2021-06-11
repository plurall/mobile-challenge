import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/core/utils/colors.dart';
import 'package:mobile_challenge/app/core/utils/constants.dart';
import 'package:mobile_challenge/app/core/utils/constrains.dart';
import 'package:mobile_challenge/app/core/utils/fonts.dart';

class UserDetailItem extends StatelessWidget {
  final String avatarUrl;
  final String login;
  final String bio;
  final String location;
  final String email;
  final Function onTap;
  UserDetailItem(
      {this.avatarUrl,
      this.login,
      this.onTap,
      this.bio,
      this.email,
      this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(
            vertical: Constrains.layoutSpace(LayoutSpace.xxs),
            horizontal: Constrains.layoutSpace(LayoutSpace.s)),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              SizedBox(
                height: Constrains.layoutSpace(LayoutSpace.xxs),
              ),
              avatarUrl == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(
                          vertical: Constrains.layoutSpace(LayoutSpace.xxs),
                          horizontal: Constrains.layoutSpace(LayoutSpace.xxs)),
                      child: Stack(children: <Widget>[
                        Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                        child: CircularProgressIndicator())))),
                        Center(
                          child: Container(
                              child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(avatarUrl),
                            backgroundColor: Colors.transparent,
                          )),
                        ),
                      ])),
              SizedBox(height: Constrains.layoutSpace(LayoutSpace.xxs)),
              _infoUser(context),
              SizedBox(height: Constrains.layoutSpace(LayoutSpace.xxs)),
            ],
          ),
        ));
  }

  Widget _infoUser(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Constrains.layoutSpace(LayoutSpace.m)),
      child: Column(
        children: [
          _aboutItem(
              title: Constants.NICKNAME_LABEL,
              description: login,
              context: context),
          SizedBox(height: Constrains.layoutSpace(LayoutSpace.xs)),
          _aboutItem(
              title: Constants.BIO_LABEL, description: bio, context: context),
          SizedBox(height: Constrains.layoutSpace(LayoutSpace.xs)),
          _aboutItem(
              title: Constants.LOCATION_LABEL,
              description: location,
              context: context),
          SizedBox(height: Constrains.layoutSpace(LayoutSpace.xs)),
          _aboutItem(
              title: Constants.EMAIL_LABEL,
              description: email,
              context: context),
          SizedBox(height: Constrains.layoutSpace(LayoutSpace.xs)),
        ],
      ),
    );
  }

  Widget _aboutItem({BuildContext context, String title, String description}) {
    return Column(
      children: [
        Container(
            width: Constrains.fullWidth(context),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: Fonts.fontSize(FontsSize.normal),
                  fontWeight: FontWeight.w600,
                  color: ColorSystem.titleItem),
            )),
        SizedBox(height: Constrains.layoutSpace(LayoutSpace.xxxs)),
        Container(
          width: Constrains.fullWidth(context),
          child: Text(description ?? Constants.NO_FILL,
              style: TextStyle(
                  fontSize: Fonts.fontSize(FontsSize.subtitle),
                  fontWeight: FontWeight.w500,
                  color: ColorSystem.descriptionItem)),
        )
      ],
    );
  }
}
