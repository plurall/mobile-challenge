import 'package:flutter/foundation.dart';

class SearchProvider {
  String _search = '';
  String get search => _search;
  set search(String value) {
    this._search = value;
  }
}
