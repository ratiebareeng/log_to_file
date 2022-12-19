/// [LogLevel]s to control logging output. Logging can be enabled to include all
/// levels above certain [LogLevel].
enum LogLevel {
  verbose,
  debug,
  info,
  warn,
  error,
  fatal,
  off,
}

/// Simple class which provide method to convert String to `LogLevel`
class LogLevelConverter {
  /// String to `LogLevel`
  static LogLevel fromStringToEnum(String? type) {
    return LogLevel.values.firstWhere((e) => e.toString() == type);
  }
}
