import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/app_controller.dart';

class CustomSwitchWidget extends StatelessWidget {
  const CustomSwitchWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDark,
      onChanged: (value) {
        AppController.instance.changeThemeViewModel.changeTheme(value);
      },
    );
  }
}
