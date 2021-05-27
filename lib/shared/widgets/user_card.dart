import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';
import 'package:mobile_challenge/utils/palette.dart';

class UserCardWidget extends StatelessWidget {
  UserCardWidget(this.user, this.onTap);

  final User user;
  final void Function(String nickname) onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap(user.nickname),
        child: Container(
          color: Palette.backgroundDarkBlack,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  user.profilePhoto,
                  height: 32,
                  width: 32,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                user.name,
                style: TextStyle(
                  color: Palette.darkWhiteText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                user.nickname,
                style: TextStyle(color: Palette.darkGrayText),
              ),
            ],
          ),
        ),
      );
}
