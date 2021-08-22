import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
    child: Platform.isIOS ? CupertinoActivityIndicator() 
    : CircularProgressIndicator(
      strokeWidth: 1,
    ),
  );
  }
}