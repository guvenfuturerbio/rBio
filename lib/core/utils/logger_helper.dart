import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtils {
  late Logger logger;

  LoggerUtils._() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 200, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false, // Should each log print contain a timestamp
      ),
    );
  }

  static late LoggerUtils _instance;

  static LoggerUtils get instance {
    _instance;
    return _instance;
  }

  // ************************** **************************

  void d(dynamic message) =>
      kDebugMode ? logger.d(message) : null; // Debug (Mavi)

  void v(dynamic message) =>
      kDebugMode ? logger.v(message) : null; // Verbose (Gri)

  void w(dynamic message) =>
      kDebugMode ? logger.w(message) : null; // Warning (Turuncu)

  void e(dynamic message) =>
      kDebugMode ? logger.e(message) : null; // Error (Kırmızı)

  void i(dynamic message) =>
      kDebugMode ? logger.i(message) : null; // Info (Mavi)

  void wtf(dynamic message) =>
      kDebugMode ? logger.wtf(message) : null; // Wtf (Pembe)
}
