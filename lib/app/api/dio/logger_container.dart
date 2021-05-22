import 'package:logger/logger.dart';

class LoggerContainer {
  Logger init() => Logger(
        printer: PrettyPrinter(
          lineLength: 90,
          methodCount: 0,
        ),
      );
}
