import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:mobile_challenge/config/environment.dart';

import '../main_common.dart';

Future<void> main() async {
  await dot_env.load(fileName: 'lib/config/production/.env');
  mainCommon(Environment.production);
}
