import 'package:flutter/material.dart';

final primaryColor = Color.fromRGBO(0, 115, 103, 1);
final primaryColorDark = Color.fromRGBO(0, 76, 69, 1);
final primaryColorLight = Color.fromRGBO(0, 176, 169, 1);

ThemeData makeAppTheme() {
  final textTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: primaryColorDark),
  );
  final inputDecorationTheme = InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColorLight)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
      alignLabelWithHint: true);
  final buttonTheme = ButtonThemeData(
    colorScheme: ColorScheme.light(primary: primaryColor),
    buttonColor: primaryColor,
    splashColor: primaryColorLight,
    textTheme: ButtonTextTheme.primary,
  );

  return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      accentColor: primaryColor,
      backgroundColor: Colors.white,
      textTheme: textTheme,
      inputDecorationTheme: inputDecorationTheme,
      buttonTheme: buttonTheme);
}
