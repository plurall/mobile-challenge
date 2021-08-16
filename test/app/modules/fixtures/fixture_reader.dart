import 'dart:io';

String fixture(String name) => File('test/app/modules/fixtures/$name').readAsStringSync();