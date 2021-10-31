import 'dart:convert';
import 'package:flutter/services.dart';

abstract class MockUtils {
  static Future getMock(String file) =>
      _parseFileToJson('assets/json/$file.json');

  static dynamic _parseFileToJson(String path) async {
    final string = await rootBundle.loadString(path);
    return jsonDecode(string);
  }
}
