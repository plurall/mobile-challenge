import 'package:flutter/material.dart';

class Palette {
  static MaterialColor black = MaterialColor(
    0xff0d1117,
    <int, Color>{
      50: Color(0xffe2e2e3),
      100: Color(0xffb6b8b9),
      200: Color(0xff86888b),
      300: Color(0xff56585d),
      400: Color(0xff31353a),
      500: Color(0xff0d1117),
      600: Color(0xff0b0f14),
      700: Color(0xff090c11),
      800: Color(0xff070a0d),
      900: Color(0xff030507),
    },
  );

  static MaterialColor darkGray = MaterialColor(
    0xff161b22,
    <int, Color>{
      50: Color(0xffe3e4e4),
      100: Color(0xffb9bbbd),
      200: Color(0xff8b8d91),
      300: Color(0xff5c5f64),
      400: Color(0xff393d43),
      500: Color(0xff161b22),
      600: Color(0xff13181e),
      700: Color(0xff101419),
      800: Color(0xff0c1014),
      900: Color(0xff06080c),
    },
  );

  static MaterialColor lightGray = MaterialColor(
    0xff30363D,
    <int, Color>{
      50: Color(0xffe6e7e8),
      100: Color(0xffc1c3c5),
      200: Color(0xff989b9e),
      300: Color(0xff6e7277),
      400: Color(0xff4f545a),
      500: Color(0xff30363d),
      600: Color(0xff2b3037),
      700: Color(0xff24292f),
      800: Color(0xff1e2227),
      900: Color(0xff13161a),
    },
  );

  static MaterialColor white = MaterialColor(
    0xffF0F6FC,
    <int, Color>{
      50: Color(0xfffdfeff),
      100: Color(0xfffbfcfe),
      200: Color(0xfff8fbfe),
      300: Color(0xfff5f9fd),
      400: Color(0xfff2f7fc),
      500: Color(0xfff0f6fc),
      600: Color(0xffeef5fc),
      700: Color(0xffecf3fb),
      800: Color(0xffe9f2fb),
      900: Color(0xffe5effa),
    },
  );

  // Dark mode Colors
  static Color backgroundDarkBlack = Palette.black;
  static Color backgroundDarkGray = Palette.darkGray;
  static Color backgroundDarkGrayBorder = Palette.lightGray;
  static Color darkWhiteText = Palette.white;
  static Color darkGrayText = Palette.darkGray.shade200;
}
