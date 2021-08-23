import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/models/user_model.dart';
import 'package:mobile_challenge/app/modules/global_widgets/photo_user.dart';

class CardUser extends StatelessWidget {
  CardUser({
    @required this.user,
    @required this.buttonText,
    @required this.onPressed,
  });

  final UserModel user;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCardInfo(),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        )
      ],
    );
  }

  Expanded _buildCardInfo() {
    return Expanded(
      child: ListView(
        children: [
          PhotoUser(url: user.avatarUrl),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name ?? user.login, style: Get.textTheme.headline4),
                SizedBox(height: 8),
                Text(user.bio ?? 'Bio não informada',
                    style: Get.textTheme.subtitle2),
                Text(user.location ?? 'Localização não informada'),
                Text(user.email ?? 'Email não informado'),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
