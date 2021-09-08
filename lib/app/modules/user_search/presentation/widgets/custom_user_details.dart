import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';

import '../../../../app_theme.dart';
import '../user_search_store.dart';

class CustomUserDetails extends StatefulWidget {

  final UserResultSearchModel user;
  final String avatar;
  final String name;
  final String login;
  final String email;
  final String location;

  final String bio;

  const CustomUserDetails({
    Key key,
    @required this.user,
    @required this.avatar,
    @required this.name,
    @required this.login,
    @required this.email,
    @required this.location,
    @required this.bio
  }) : super(key: key);

  @override
  _CustomUserDetailsState createState() => _CustomUserDetailsState();
}

class _CustomUserDetailsState extends ModularState<CustomUserDetails,
    UserSearchStore> {
  @override
  Widget build(BuildContext context) {
    var random = new Random();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(     // Replace this child with your own
            elevation: 8.0,
            shape: CircleBorder(),
            child: ClipOval(
              child: FadeInImage(
                width: 120,
                image: NetworkImage(this.widget.avatar),
                placeholder: AssetImage(
                    "assets/images/avatar_${random.nextInt(3)}.png"),
                imageErrorBuilder: (context,_,stackTrace){
                  return Image.asset(
                      "assets/images/avatar_${random.nextInt(3)}.png");
                },
              ),
            ),
          ),
          SizedBox(height: 16,),
          Visibility(
            visible: this.widget.name != null,
            child: Text(this.widget.name ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Raleway-Bold"
              ),
            ),
          ),
          Text(this.widget.login,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Raleway-Bold"
            ),
          ),
          SizedBox(height: 16,),
          Visibility(
            visible: this.widget.location != null,
            child: Column(
              children: [
                Text(this.widget.location ?? "",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Raleway"
                  ),
                ),
                SizedBox(height: 16,),
              ],
            ),
          ),
          Visibility(
              visible: this.widget.email != null,
              child: Column(
                children: [
                  Text(this.widget.email ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Raleway"
                    ),
                  ),
                  SizedBox(height: 16,),
                ],
              )
          ),
          Visibility(
              visible: this.widget.bio != null,
              child: Column(
                children: [
                  Text(this.widget.bio ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Raleway"
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              )
          ),
          controller.isFavorite == false ? ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    AppTheme.buttonAndIconColor
                ),
              ),
              onPressed: (){
                controller.saveUser(this.widget.user);
                controller.isFavVerification(this.widget.login);
                controller.updateFavList(true);
              },
              child: Text("Favoritar",
                style: TextStyle(
                  fontSize: 18,
                ),
              )
          )
              : Icon(Icons.star, size: 40,
            color: AppTheme.buttonAndIconColor,)
        ],
      ),
    );
  }
}
