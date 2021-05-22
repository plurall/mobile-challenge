import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';
import 'package:mobile_challenge/utils/palette.dart';

class UserDetailsCard extends StatelessWidget {
  User user;

  UserDetailsCard(this.user);

  Widget _infoChip({@required IconData icon, @required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Palette.darkWhiteText,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            color: Palette.darkWhiteText,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final double imgPadding = 64;
    final double commonPadding = imgPadding / 2;
    return Padding(
      padding: EdgeInsets.all(commonPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: commonPadding, bottom: commonPadding / 2),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(media.size.width - imgPadding)),
                  border: Border.all(
                      width: 2,
                      color: Palette.backgroundDarkGrayBorder,
                      style: BorderStyle.solid)),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(media.size.width - imgPadding),
                child: Image.network(
                  user.profilePhoto,
                  height: media.size.width - imgPadding,
                  width: media.size.width - imgPadding,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            user.name,
            style: TextStyle(
                color: Palette.darkWhiteText,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          Text(
            user.nickname,
            style: TextStyle(
                color: Palette.darkGrayText,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.only(top: commonPadding / 2),
            child: Text(
              user.bio,
              style: TextStyle(
                color: Palette.darkWhiteText,
                fontSize: 16,
              ),
            ),
          ),
          _infoChip(icon: Icons.place_outlined, text: user.location),
          _infoChip(icon: Icons.email_outlined, text: user.email),
        ],
      ),
    );
  }
}
