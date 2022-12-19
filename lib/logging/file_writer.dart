import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

import 'log.dart';
import 'log_level.dart';

/// Write log message to a file
class FileWriter {
  String defaultLogFileName = 'tft_log';
  File? _logFile;

  static final _lock = Lock();

  FileWriter._create();

  static Future<FileWriter> init(String? logFileName) async {
    var writer = FileWriter._create();

    await writer.initializeFile(logFileName);
    return writer;
  }

  /// initialize log file
  Future initializeFile(
    String? canonicalLogFileName,
  ) async {
    Directory directory = await getApplicationDocumentsDirectory();
    log(directory.path);
    String filePath =
        '${directory.path}/${canonicalLogFileName ?? defaultLogFileName}.txt';

    if (Platform.isWindows) {
      filePath.replaceAll('/', '\\');
    }

    _logFile = _createLogFile(filePath);
    log('file to write to: ${_logFile!.path}');
  }

  /// write log event details to log file
  void logToFile({
    required LogEvent event,
  }) async {
    if (event.level == LogLevel.off) {
      return;
    }
    if (LogLevel.values.indexOf(Log.level) <=
        LogLevel.values.indexOf(event.level)) {
      String text = '${DateTime.now()}:';
      if (event.className != null && event.className!.isNotEmpty) {
        text += '[${event.className}]';
      }
      if (event.methodName != null && event.methodName!.isNotEmpty) {
        text += '[${event.methodName}  ] ';
      }
      text += '${event.level.name.toUpperCase()}: ';
      text += '${event.message} ';
      if (event.exception != null) {
        text += '${event.exception.toString()} ';
      }
      if (event.exception != null) {
        text += '${event.stackTrace}';
      }
      text += '\n';

      /// write to file
      await _lock.synchronized(() async {
        await writeToLogFile(
            text: text, overrideExisting: event.overrideExisting);
      });
    }
  }

  ///  write data to file
  Future<File> writeToLogFile({required String text, bool? overrideExisting}) {
    return _logFile!.writeAsString(text,
        mode: overrideExisting == null || overrideExisting
            ? FileMode.writeOnly
            : FileMode.append,
        flush: true);
  }

  static File _createLogFile(canonicalLogFileName) =>
      File(canonicalLogFileName);
}
