import 'package:logging/logging.dart';
import 'dart:developer' as developer;

class Log {
  static final Logger _logger = Logger('vuldt');

  static void initialize() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      developer.log(
        _formatMessage(rec),
        name: 'GETX',
        time: rec.time,
        level: _getLogLevel(rec.level),
      );
    });
  }

  static String _formatMessage(LogRecord rec) {
    final formattedTime = '${rec.time}';
    switch (rec.level.name) {
      case 'INFO':
        return '$formattedTime: ${rec.message}';
        // return '$formattedTime: \x1B[32m${rec.message}\x1B[0m';
      case 'WARNING':
        return '$formattedTime: ${rec.message}';
        // return '$formattedTime: \x1B[33m${rec.message}\x1B[0m';
      case 'SEVERE':
        return '$formattedTime: ${rec.message}';
        // return '$formattedTime: \x1B[31m${rec.message}\x1B[0m';
      default:
        return rec.message;
    }
  }

  static int _getLogLevel(Level level) {
    switch (level.name) {
      case 'INFO':
        return 800;
      case 'WARNING':
        return 900;
      case 'SEVERE':
        return 1000;
      default:
        return 700;
    }
  }

  static void info(String message) {
    _logger.info(message);
  }

  static void warning(String message) {
    _logger.warning(message);
  }

  static void severe(String message) {
    _logger.severe(message);
  }
}
