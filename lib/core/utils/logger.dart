import 'dart:developer' as developer;

/// Professional logging utility for SELous
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();
  
  static const String _prefix = '[SELous]';
  
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _log('DEBUG', message, error: error, stackTrace: stackTrace);
  }
  
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log('INFO', message, error: error, stackTrace: stackTrace);
  }
  
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log('WARNING', message, error: error, stackTrace: stackTrace);
  }
  
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log('ERROR', message, error: error, stackTrace: stackTrace);
  }
  
  void fatal(String message, {Object? error, StackTrace? stackTrace}) {
    _log('FATAL', message, error: error, stackTrace: stackTrace);
  }
  
  void _log(
    String level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '$_prefix [$timestamp] [$level] $message';
    
    developer.log(
      logMessage,
      error: error,
      stackTrace: stackTrace,
      name: 'SELous',
    );
  }
}
