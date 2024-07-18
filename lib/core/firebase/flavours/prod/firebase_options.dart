// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8_RaK8zySAucJQMVf0kcURRaV2SYfj68',
    appId: '1:1040213415900:web:775de65570131854a56119',
    messagingSenderId: '1040213415900',
    projectId: 'yandextodo-642a1',
    authDomain: 'yandextodo-642a1.firebaseapp.com',
    databaseURL: 'https://yandextodo-642a1-default-rtdb.firebaseio.com',
    storageBucket: 'yandextodo-642a1.appspot.com',
    measurementId: 'G-XP8L7Q8RFT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-zt8DiN0SyaW5pVGMZFCii-bwkcjf6R0',
    appId: '1:1040213415900:android:9e6898ed478c7e39a56119',
    messagingSenderId: '1040213415900',
    projectId: 'yandextodo-642a1',
    databaseURL: 'https://yandextodo-642a1-default-rtdb.firebaseio.com',
    storageBucket: 'yandextodo-642a1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6XohUU6BrltC5Mwri2CERrVnQSdN6tk0',
    appId: '1:1040213415900:ios:5a661c2aba20f78da56119',
    messagingSenderId: '1040213415900',
    projectId: 'yandextodo-642a1',
    databaseURL: 'https://yandextodo-642a1-default-rtdb.firebaseio.com',
    storageBucket: 'yandextodo-642a1.appspot.com',
    iosBundleId: 'com.example.yndxTodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6XohUU6BrltC5Mwri2CERrVnQSdN6tk0',
    appId: '1:1040213415900:ios:5a661c2aba20f78da56119',
    messagingSenderId: '1040213415900',
    projectId: 'yandextodo-642a1',
    databaseURL: 'https://yandextodo-642a1-default-rtdb.firebaseio.com',
    storageBucket: 'yandextodo-642a1.appspot.com',
    iosBundleId: 'com.example.yndxTodo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8_RaK8zySAucJQMVf0kcURRaV2SYfj68',
    appId: '1:1040213415900:web:b55823be4ede30e5a56119',
    messagingSenderId: '1040213415900',
    projectId: 'yandextodo-642a1',
    authDomain: 'yandextodo-642a1.firebaseapp.com',
    databaseURL: 'https://yandextodo-642a1-default-rtdb.firebaseio.com',
    storageBucket: 'yandextodo-642a1.appspot.com',
    measurementId: 'G-3F3TBEL83P',
  );

}