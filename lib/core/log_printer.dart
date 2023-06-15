import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

Logger getLogger({required String className}) {
  return Logger(printer: CustomLogPrinter(className));
}

class CustomLogPrinter extends LogPrinter {
  final String className;
  final Map<Level, AnsiColor> levelColors;
  final Map<Level, String> levelEmojis;

  CustomLogPrinter(this.className)
      : levelColors = PrettyPrinter.levelColors,
        levelEmojis = PrettyPrinter.levelEmojis;

  @override
  List<String> log(LogEvent event) {
    var color = levelColors[event.level];
    var emoji = levelEmojis[event.level];
    if (kDebugMode) {
      print(color!('$emoji $className - ${event.message}'));
    }
    return [event.message];
  }
}
