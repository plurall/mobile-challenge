import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/user_details/presentation/widgets/user_details_card.dart';
import 'package:mobile_challenge/utils/palette.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundDarkBlack,
      body: UserDetailsCard(),
    );
  }
}
