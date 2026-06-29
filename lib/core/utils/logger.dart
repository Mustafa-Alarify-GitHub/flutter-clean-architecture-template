import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// A performance-optimized utility service for managing structured diagnostic runtime logs.
///
/// This service leverages ANSI escape codes to output stylized, color-coordinated terminal streams
/// categorized by urgency levels. It ensures that execution prints are strictly evaluated inside
/// debug builds (`kDebugMode`), leaving production application runtimes quiet and secure.
class AppLogger {
  /// Emits a diagnostic informational log stream colored in **Blue**.
  ///
  /// Use this method to log standard initialization states, routing configurations, or general lifecycle trace elements.
  ///
  /// * [message]: The diagnostic message string to print onto the debugger console.
  ///
  /// ### Example:
  /// ```dart
  /// AppLogger.info('LocalizationService initialization initialized completely.');
  /// ```
  static void info(String message) {
    _log('\x1B[34m$message\x1B[0m', name: 'INFO');
  }

  /// Emits a operational milestone success log stream colored in **Green**.
  ///
  /// Use this method when a task completes successfully, such as completing local sync transactions or caching records.
  ///
  /// * [message]: The success milestone statement to print.
  ///
  /// ### Example:
  /// ```dart
  /// AppLogger.success('Product data successfully cached into local Hive DB box.');
  /// ```
  static void success(String message) {
    _log('\x1B[32m$message\x1B[0m', name: 'SUCCESS');
  }

  /// Emits an alerting operational warning log stream colored in **Yellow**.
  ///
  /// Use this method to highlight sub-optimal situations or non-fatal anomalies (e.g., pulling fallback asset caches when connections timeout).
  ///
  /// * [message]: The explicit warning argument description to log.
  ///
  /// ### Example:
  /// ```dart
  /// AppLogger.warning('Network connection dropped. Attempting to pull localized repository cache.');
  /// ```
  static void warning(String message) {
    _log('\x1B[33m$message\x1B[0m', name: 'WARNING');
  }

  /// Emits a critical failure exception diagnostic log stream colored in **Red**.
  ///
  /// Use this to capture severe block exceptions, parsing anomalies, or unhandled failure responses.
  ///
  /// * [message]: Descriptive context text summarizing the failure landscape.
  /// * [error]: The raw dynamic exception error object runtime node caught by a try/catch block.
  /// * [stackTrace]: The precise code execution trace parameters highlighting where the execution derailed.
  ///
  /// ### Example:
  /// ```dart
  /// try {
  ///   final data = await apiConsumer.get('/user');
  /// } catch (e, stack) {
  ///   AppLogger.error('Failed to query remote user session information.', e, stack);
  /// }
  /// ```
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log(
      '\x1B[31m$message\x1B[0m',
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Central encapsulated logging proxy that passes messages to [developer.log].
  ///
  /// Enforces structural [kDebugMode] runtime gates to eliminate printing strings in client production builds.
  static void _log(
    String message, {
    String name = '',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(message, name: name, error: error, stackTrace: stackTrace);
    }
  }
}

// ===========================================================================
// Global Helper Proxy Function Handlers
// ===========================================================================

/// Global utility shortcut to proxy [AppLogger.info] execution calls cleanly.
void logInfo(String msg) => AppLogger.info(msg);

/// Global utility shortcut to proxy [AppLogger.success] execution calls cleanly.
void logSuccess(String msg) => AppLogger.success(msg);

/// Global utility shortcut to proxy [AppLogger.warning] execution calls cleanly.
void logWarning(String msg) => AppLogger.warning(msg);

/// Global utility shortcut to proxy [AppLogger.error] execution calls cleanly.
void logError(String msg) => AppLogger.error(msg);
