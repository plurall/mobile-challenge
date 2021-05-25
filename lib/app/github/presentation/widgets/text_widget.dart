import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/core/theme/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String? text;

  const TextWidget({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text == null ? '' : text!,
      style: TextStyle(
        color: AppColors.text_primary,
      ),
    );
  }
}
