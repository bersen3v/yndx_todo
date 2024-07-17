import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:yndx_todo/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/data/http_overrides.dart';
import 'package:yndx_todo/core/firebase/analytics.dart';
import 'package:yndx_todo/core/firebase/remote_config_service.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/firebase_options.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      HttpOverrides.global = MyHttpOverrides();
      await Hive.initFlutter();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await firebaseRemoteConfigService.init();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
        );
        return true;
      };

      analytics.setAnalyticsCollectionEnabled(true);

      runApp(const App());
    },
    (e, s) {
      logger.d(e, stackTrace: s);
    },
  );
}
