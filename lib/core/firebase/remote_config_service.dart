import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/core/styles/styles.dart';

final firebaseRemoteConfigService = FirebaseRemoteConfigService(
  firebaseRemoteConfig: FirebaseRemoteConfig.instance,
);

class FirebaseRemoteConfigService {
  const FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig,
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;

  Future<void> init() async {
    try {
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
    } catch (e) {
      logger.d(e);
    }
  }

  Color getTaskColor() {
    String answer = firebaseRemoteConfig.getString('color');
    Color color = answer == 'red' ? Colors.red : Styles.grey06;
    return color;
  }
}
