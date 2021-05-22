import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelTextWidget;
  final IconData prefixIconDataWidget;

  final TextEditingController textFieldController;

  TextFieldWidget({
    this.labelTextWidget,
    this.prefixIconDataWidget,
    this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: labelTextWidget,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        prefixIcon: Icon(
          prefixIconDataWidget,
          size: 18,
          color: Colors.black,
        ),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        focusColor: Colors.black,
      ),
    );
  }
}
