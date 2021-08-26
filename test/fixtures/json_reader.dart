import 'dart:io';

String jsonReader(String name) {
  return File('test/fixtures/$name').readAsStringSync();
}
