import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    colors: true,
    lineLength: 160,
  ),
);

mixin class LoggerMixin<T> {
  logError(String methodName, Object? message) {
    if (!kReleaseMode) {
      _logger.e('$T, method: $methodName,message: $message');
    }
    // send this to sentry or some other logging service
  }

  logInfo(String methodName, Object? message) {
    if (!kReleaseMode) {
      _logger.i('$T, method: $methodName, message: $message');
    }
  }

  logDebug(String methodName, Object? message) {
    if (!kReleaseMode) {
      _logger.d('$T, method: $methodName, message: $message');
    }
  }
}
