import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yndx_todo/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/data/http_overrides.dart';
import 'package:yndx_todo/core/logger.dart';

void main() async {
  runZonedGuarded(
    () async {
      HttpOverrides.global = MyHttpOverrides();
      await Hive.initFlutter();
      runApp(const App());
    },
    (e, s) {
      logger.e(e, stackTrace: s);
    },
  );
}
