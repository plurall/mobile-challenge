import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/models/profile_model.dart';
class FavoriteButton extends StatelessWidget {

  ProfileModel profileModel;
  final Function(ProfileModel value) saveFavorite;

  FavoriteButton(this.profileModel,this.saveFavorite);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(280, 5, 0, 0),
        child: GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child:IconButton(
              icon:Icon(Icons.favorite_border,color: Colors.red[700],),
            ),
          ),
          onTap: (){
            this.saveFavorite(this.profileModel);
          },
        )
    );
  }
}
