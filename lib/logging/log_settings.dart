import 'dart:developer';

import 'log.dart';
import 'log_level.dart';

void setUpLog({String? logFileName, LogLevel? logLevel}) async {
  log('setting up log file');
  await Log.init(
    fileName: logFileName,
    logLevel: logLevel,
  );
}
