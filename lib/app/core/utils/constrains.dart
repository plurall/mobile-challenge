import 'package:flutter/material.dart';

class Constrains {
  static const double margin = 16;

  static double layoutSpace(LayoutSpace layoutSpace) {
    switch (layoutSpace) {
      case LayoutSpace.xxxs:
        return 4;
      case LayoutSpace.xxs:
        return 8;
      case LayoutSpace.xs:
        return 12;
      case LayoutSpace.s:
        return 16;
      case LayoutSpace.m:
        return 24;
      case LayoutSpace.l:
        return 32;
      case LayoutSpace.xl:
        return 40;
      case LayoutSpace.xxl:
        return 48;
      case LayoutSpace.xxxl:
        return 64;
    }
    return 0;
  }

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double fullHeightModal(BuildContext context) {
    return MediaQuery.of(context).size.height - 60;
  }
}

enum LayoutSpace { xxxs, xxs, xs, s, m, l, xl, xxl, xxxl }
