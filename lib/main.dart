import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:yndx_todo/app.dart';
import 'package:yndx_todo/core/data/data_fetcher.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

final logger = Logger();
