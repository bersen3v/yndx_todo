import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:yndx_todo/core/logger.dart';

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
      logger.e(e);
    }
  }

  String getTaskColor() {
    String answer = firebaseRemoteConfig.getString('color');
    logger.e(answer);
    return answer;
  }
}
