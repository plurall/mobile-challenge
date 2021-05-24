import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;

    return File('$path/$fileName');
  }

  Future<Map<String, Object>> readDb(String fileName) async {
    try {
      final file = await _localFile(fileName);
      final contents = await file.readAsString();

      return JsonDecoder().convert(contents);
    } catch (e) {
      return {};
    }
  }

  Future<File> writeDb(String fileName, Map<String, Object> json) async {
    final file = await _localFile(fileName);

    return file.writeAsString(JsonEncoder().convert(json));
  }
}
