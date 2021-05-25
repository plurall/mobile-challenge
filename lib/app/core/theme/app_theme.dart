import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get dark => ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      );
}
