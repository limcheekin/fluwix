/// Simple Logging class
class Logger {
  /// Simple info log
  static void logInfo(String message, {bool lineBreak = false}) {
    if (lineBreak) {
      print('\n[INFO] $message');
    } else {
      print('[INFO] $message');
    }
  }

  /// Simple warning log
  static void logWarning(String message) {
    print('[WARNING] $message');
  }

  /// Simple error log
  static void logError(String message) {
    print('[ERROR] $message');
  }

  /// Log configuration key/value pair
  static void logConfigKeyValue(String key, String value) {
    print('[CONFIG] $key = $value');
  }
}
