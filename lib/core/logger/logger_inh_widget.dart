import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class LoggerInhWidget extends InheritedWidget {
  const LoggerInhWidget({required this.logger, super.key, required this.child})
      : super(child: child);

  final Logger logger;
  final Widget child;

  static LoggerInhWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LoggerInhWidget>();
  }

  @override
  bool updateShouldNotify(LoggerInhWidget oldWidget) {
    return true;
  }
}
