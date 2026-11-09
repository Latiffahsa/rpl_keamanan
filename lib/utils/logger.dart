import 'package:flutter/foundation.dart';

/// Level log yang tersedia.
enum LogLevel { debug, info, warning, error }

/// Logger terstruktur yang hanya aktif di mode debug.
///
/// Pesan otomatis disensor jika mengandung pola data sensitif
/// seperti token, password, pin, atau API key.
class Logger {
  Logger._();

  static final RegExp _sensitivePattern = RegExp(
    r'(token|password|pin|api[_-]?key|authorization|secret)\s*[:=]\s*\S+',
    caseSensitive: false,
  );

  static void debug(String message) => _log(LogLevel.debug, message);
  static void info(String message) => _log(LogLevel.info, message);
  static void warning(String message) => _log(LogLevel.warning, message);

  static void error(String message, [Object? error]) {
    _log(LogLevel.error, error == null ? message : '$message: $error');
  }

  static void _log(LogLevel level, String message) {
    if (!kDebugMode) return; // tidak ada log di release
    debugPrint('[${level.name.toUpperCase()}] ${_mask(message)}');
  }

  /// Mengganti nilai data sensitif dengan `***`.
  static String _mask(String message) {
    return message.replaceAllMapped(
      _sensitivePattern,
      (m) => '${m.group(1)}=***',
    );
  }
}
