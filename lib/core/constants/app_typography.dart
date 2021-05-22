import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle splashPageTitle(BuildContext context) =>
      Theme.of(context)
          .textTheme
          .headline5
          .copyWith(fontWeight: FontWeight.bold);

  static TextStyle bodyText(BuildContext context) =>
      Theme.of(context).textTheme.subtitle1;

  static TextStyle pageTitle(BuildContext context) =>
      Theme.of(context).textTheme.headline6;

  static TextStyle profileHeaderStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .headline5
      .copyWith(color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle subtitle(BuildContext context) =>
      Theme.of(context).textTheme.subtitle2.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          );

  static TextStyle usernameTitle(BuildContext context) =>
      Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.bold,
          );
}
