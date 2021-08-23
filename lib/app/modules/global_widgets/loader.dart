import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Get.theme.accentColor),
    );
  }
}
