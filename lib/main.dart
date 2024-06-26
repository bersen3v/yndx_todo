import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:yndx_todo/app.dart';

void main() {
  runZonedGuarded(() {
    runApp(const App());
  }, (o, s) {
    logger.f(o, stackTrace: s);
  });
}

final logger = Logger();
