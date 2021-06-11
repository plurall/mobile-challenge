import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/shared/utils/colors.dart';
import 'package:mobile_challenge/app/shared/utils/constrains.dart';
import 'package:mobile_challenge/app/shared/utils/fonts.dart';

class UserItem extends StatelessWidget {
  final String avatarUrl;
  final String login;
  final Function onTap;
  UserItem({this.avatarUrl, this.login, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(
            vertical: Constrains.layoutSpace(LayoutSpace.xxs),
            horizontal: Constrains.layoutSpace(LayoutSpace.s)),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
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
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                        child: CircularProgressIndicator())))),
                        Center(
                          child: Container(
                              child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(avatarUrl),
                            backgroundColor: Colors.transparent,
                          )),
                        ),
                      ])),
              SizedBox(width: Constrains.layoutSpace(LayoutSpace.xxs)),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: Constrains.layoutSpace(LayoutSpace.s)),
                child: Text(
                  login,
                  style: TextStyle(
                      fontSize: Fonts.fontSize(FontsSize.title),
                      fontWeight: FontWeight.w600,
                      color: ColorSystem.titleItem),
                ),
              )),
              SizedBox(width: Constrains.layoutSpace(LayoutSpace.xxs)),
            ],
          ),
        ));
  }
}
