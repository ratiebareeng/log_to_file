import 'dart:core';

import 'file_writer.dart';
import 'log_level.dart';

class LogEvent {
  final LogLevel level;
  final String message; // dynamic
  final String? className;
  final String? methodName;
  final Object? exception; // dynamic
  final StackTrace? stackTrace;
  final bool? overrideExisting;

  LogEvent({
    required this.level,
    required this.message,
    this.className,
    this.methodName,
    this.exception,
    this.stackTrace,
    this.overrideExisting,
  });
}

class Log {
  static LogLevel level = LogLevel.verbose;

  static late FileWriter _fileWriter;

  /// Private constructor
  Log._create();

  /// initialize FileWriter; get reference to log file
  static Future<Log> init({String? fileName, LogLevel? logLevel}) async {
    if (logLevel != null) {
      level = logLevel;
    }
    var log = Log._create();
    _fileWriter = await FileWriter.init(fileName);
    return log;
  }

  static Future<void> i(
    String message, {
    String? className,
    String? methodName,
    Object? exception,
    StackTrace? stacktrace,
    bool overrideExisting = false,
  }) async {
    return _fileWriter.logToFile(
      event: LogEvent(
        overrideExisting: overrideExisting,
        level: LogLevel.info,
        message: message,
        className: className,
        methodName: methodName,
        exception: exception,
        stackTrace: stacktrace,
      ),
    );
  }

  static Future<void> d(
    String message, {
    String? className,
    String? methodName,
    Object? exception,
    StackTrace? stacktrace,
    bool overrideExisting = false,
  }) async {
    return _fileWriter.logToFile(
      event: LogEvent(
        overrideExisting: overrideExisting,
        level: LogLevel.debug,
        message: message,
        className: className,
        methodName: methodName,
        exception: exception,
        stackTrace: stacktrace,
      ),
    );
  }

  static Future<void> e(
    String message, {
    String? className,
    String? methodName,
    Object? exception,
    StackTrace? stacktrace,
    bool overrideExisting = false,
  }) async {
    return _fileWriter.logToFile(
      event: LogEvent(
        overrideExisting: overrideExisting,
        level: LogLevel.error,
        message: message,
        className: className,
        methodName: methodName,
        exception: exception,
        stackTrace: stacktrace,
      ),
    );
  }

  static Future<void> v(
    String message, {
    String? className,
    String? methodName,
    Object? exception,
    StackTrace? stacktrace,
    bool overrideExisting = false,
  }) async {
    return _fileWriter.logToFile(
      event: LogEvent(
        overrideExisting: overrideExisting,
        level: LogLevel.verbose,
        message: message,
        className: className,
        methodName: methodName,
        exception: exception,
        stackTrace: stacktrace,
      ),
    );
  }

  static Future w(
    String message, {
    String? className,
    String? methodName,
    Object? exception,
    StackTrace? stacktrace,
    bool overrideExisting = false,
  }) async {
    return _fileWriter.logToFile(
      event: LogEvent(
        overrideExisting: overrideExisting,
        level: LogLevel.warn,
        message: message,
        className: className,
        methodName: methodName,
        exception: exception,
        stackTrace: stacktrace,
      ),
    );
  }

  static Future f(
    String message, {
    String? className,
    String? methodName,
    Object? exception,
    StackTrace? stacktrace,
    bool overrideExisting = false,
  }) async {
    return _fileWriter.logToFile(
      event: LogEvent(
        overrideExisting: overrideExisting,
        level: LogLevel.fatal,
        message: message,
        className: className,
        methodName: methodName,
        exception: exception,
        stackTrace: stacktrace,
      ),
    );
  }
}
