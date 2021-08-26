import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  Environments._();

  static Future<void> loadEnvs() async {
    await dotenv.load(fileName: '.env');
  }

  static String? param(String paramName) => dotenv.env[paramName];
}
