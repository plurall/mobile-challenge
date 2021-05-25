import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/core/theme/app_colors.dart';

class SearchWidget extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchWidget({Key? key, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Buscar usuário',
        labelStyle: TextStyle(
          color: AppColors.text_white,
        ),
      ),
    );
  }
}
