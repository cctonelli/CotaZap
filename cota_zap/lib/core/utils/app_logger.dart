import 'package:flutter/foundation.dart';

/// Centralizador de logs para facilitar o debug de comunicações (Supabase, Drift, APIs)
class AppLogger {
  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      print('ℹ️ [INFO]${tag != null ? ' [$tag]' : ''}: $message');
    }
  }

  static void success(String message, {String? tag}) {
    if (kDebugMode) {
      print('✅ [SUCCESS]${tag != null ? ' [$tag]' : ''}: $message');
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      print('⚠️ [WARNING]${tag != null ? ' [$tag]' : ''}: $message');
    }
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace, String? tag}) {
    if (kDebugMode) {
      print('❌ [ERROR]${tag != null ? ' [$tag]' : ''}: $message');
      if (error != null) print('   Error details: $error');
      if (stackTrace != null) print('   StackTrace: $stackTrace');
    }
  }
}
