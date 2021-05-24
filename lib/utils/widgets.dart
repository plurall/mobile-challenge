import 'package:flutter/material.dart';

import 'constants.dart';

TextField textField(String? value, Icon icon, String labelText) => TextField(
      readOnly: true,
      controller: TextEditingController()..text = value ?? noValue,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
