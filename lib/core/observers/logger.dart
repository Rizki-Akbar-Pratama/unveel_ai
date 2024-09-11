import 'dart:developer';

class Logger {
  // Blue
  static void info(
    String? message,
  ) {
    log(
      "\x1B[34m$message\x1B[0m",
      name: "🥸",
    );
  }

  // Green
  static void success(
    String? message,
  ) {
    log(
      "\x1B[32m$message\x1B[0m",
      name: "🤩",
    );
  }

  // Error
  static void error(
    String? message,
  ) {
    log(
      "\x1B[31m$message\x1B[0m",
      name: "🤬",
    );
  }

  // Yellow
  static void warning(
    String? message,
  ) {
    log(
      "\x1B[33m$message\x1B[0m",
      name: "😔",
    );
  }
}
