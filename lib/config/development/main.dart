
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

import '../environment.dart';
import '../main_common.dart';

Future<void> main() async {
  await dot_env.load(fileName: 'lib/config/development/.env');
  mainCommon(Environment.development);
}
