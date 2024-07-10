import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yndx_todo/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/data/http_overrides.dart';

void main() async {
  // runZonedGuarded(
  //   () async {
  //     HttpOverrides.global = MyHttpOverrides();
  //     await Hive.initFlutter();
  //     runApp(const Providers());
  //   },
  //   (e, s) {
  //     logger.e(e, stackTrace: s);
  //   },
  // );
  HttpOverrides.global = MyHttpOverrides();
  Hive.initFlutter();
  runApp(const App());
}
