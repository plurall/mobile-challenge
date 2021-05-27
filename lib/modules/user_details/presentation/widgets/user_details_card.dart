import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';
import 'package:mobile_challenge/utils/palette.dart';

class UserDetailsCard extends StatefulWidget {
  User user;
  void Function() favoriteToggleCallback;

  UserDetailsCard(
    this.user,
    this.favoriteToggleCallback,
  );

  @override
  State<StatefulWidget> createState() => _UserDetailsCard();
}

class _UserDetailsCard extends State<UserDetailsCard> {
  _UserDetailsCard();

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

  Widget _hideIfEmpty({String check, Widget child}) {
    if (check == null || check.isEmpty) {
      return SizedBox();
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final double imgPadding = 64;
    final double commonPadding = imgPadding / 2;
    final double imageSize = media.size.width - imgPadding;

    final User user = widget.user;
    final bool favorite = widget.user.favorite;

    Widget _profilePhoto() {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(imageSize)),
            border: Border.all(
                width: 2,
                color: Palette.backgroundDarkGrayBorder,
                style: BorderStyle.solid)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(imageSize),
          child: CachedNetworkImage(
            imageUrl: user.profilePhoto,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      );
    }

    Widget _favoriteButton() {
      return Padding(
        padding: EdgeInsets.only(top: imageSize / 1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                widget.favoriteToggleCallback();
              },
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Palette.backgroundDarkBlack,
                  borderRadius: BorderRadius.all(Radius.circular(imageSize)),
                  border: Border.all(
                      width: 2,
                      color: Palette.backgroundDarkGrayBorder,
                      style: BorderStyle.solid),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: Palette.darkWhiteText,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      favorite ? 'Favorite' : 'Add Favorite',
                      style: TextStyle(color: Palette.darkWhiteText),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(commonPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: commonPadding, bottom: commonPadding / 2),
            child: Stack(
              children: [
                _profilePhoto(),
                _favoriteButton(),
              ],
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
          _hideIfEmpty(
            check: user.bio,
            child: Padding(
              padding: EdgeInsets.only(top: commonPadding / 2),
              child: Text(
                user.bio,
                style: TextStyle(
                  color: Palette.darkWhiteText,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          _hideIfEmpty(
            check: user.location,
            child: _infoChip(
              icon: Icons.place_outlined,
              text: user.location,
            ),
          ),
          _hideIfEmpty(
            check: user.email,
            child: _infoChip(
              icon: Icons.email_outlined,
              text: user.email,
            ),
          ),
        ],
      ),
    );
  }
}
