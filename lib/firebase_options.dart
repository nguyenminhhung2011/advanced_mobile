// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB_CjXVy3X6HzM0b06TqXA1QSWJSU8nX40',
    appId: '1:465590336838:web:30e9ef6552e3a6f89ff947',
    messagingSenderId: '465590336838',
    projectId: 'lettutor-d58f0',
    authDomain: 'lettutor-d58f0.firebaseapp.com',
    storageBucket: 'lettutor-d58f0.appspot.com',
    measurementId: 'G-W0FHD4MVTH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwm4ULXi_MSP-LEzovZaOiokxGy4ldktc',
    appId: '1:465590336838:android:544a330af2af4b9f9ff947',
    messagingSenderId: '465590336838',
    projectId: 'lettutor-d58f0',
    storageBucket: 'lettutor-d58f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3SpVTD2tBbzTplwLSkwO2jlIAYA9L2BQ',
    appId: '1:465590336838:ios:9865b05f6b9f097f9ff947',
    messagingSenderId: '465590336838',
    projectId: 'lettutor-d58f0',
    storageBucket: 'lettutor-d58f0.appspot.com',
    iosBundleId: 'com.example.flutterBaseCleanArchitecture',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3SpVTD2tBbzTplwLSkwO2jlIAYA9L2BQ',
    appId: '1:465590336838:ios:8bd9b727a22d0a559ff947',
    messagingSenderId: '465590336838',
    projectId: 'lettutor-d58f0',
    storageBucket: 'lettutor-d58f0.appspot.com',
    iosBundleId: 'com.example.flutterBaseCleanArchitecture.RunnerTests',
  );
}
