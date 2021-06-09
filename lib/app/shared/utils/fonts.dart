class Fonts {
  static const double button = 14;
  static double fontSize(FontsSize size) {
    switch (size) {
      case FontsSize.min:
        return 11;
      case FontsSize.subtitle:
        return 13;
      case FontsSize.normal:
        return 14;
      case FontsSize.title:
        return 16;
      case FontsSize.section:
        return 20;
      case FontsSize.max:
        return 24;

      case FontsSize.page:
        return 32;
    }
    return 0;
  }
}

enum FontsSize { min, normal, title, subtitle, section, max, page }
