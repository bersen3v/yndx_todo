import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:yndx_todo/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/data/http_overrides.dart';
import 'package:yndx_todo/core/firebase/analytics.dart';
import 'package:yndx_todo/core/firebase/flavours/dev/firebase_options.dart'
    as dev;
import 'package:yndx_todo/core/firebase/flavours/prod/firebase_options.dart'
    as prod;
import 'package:yndx_todo/core/firebase/remote_config_service.dart';
import 'package:yndx_todo/core/logger.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      HttpOverrides.global = MyHttpOverrides();
      await Hive.initFlutter();

      const bool isDev = bool.fromEnvironment(
        'IS_DEV',
        defaultValue: false,
      );

      await Firebase.initializeApp(
        options: isDev
            ? dev.DefaultFirebaseOptions.currentPlatform
            : prod.DefaultFirebaseOptions.currentPlatform,
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

      await analytics.setAnalyticsCollectionEnabled(true);

      runApp(
        const App(
          isDev: isDev,
        ),
      );
    },
    (e, s) {
      logger.d(e, stackTrace: s);
    },
  );
}
