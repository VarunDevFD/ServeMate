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
    apiKey: 'AIzaSyBkionTEdMEkpjW0JZsBY1MCLku2S3gCHU',
    appId: '1:54251147633:web:325b04eb3d1c618f2026d0',
    messagingSenderId: '54251147633',
    projectId: 'wedding-rental-595ab',
    authDomain: 'wedding-rental-595ab.firebaseapp.com',
    storageBucket: 'wedding-rental-595ab.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByBRstciOpAcbysqU8dspV48LJUlYl_6E',
    appId: '1:54251147633:android:23acf4ec4e500f2c2026d0',
    messagingSenderId: '54251147633',
    projectId: 'wedding-rental-595ab',
    storageBucket: 'wedding-rental-595ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQLZkgMkITZnC0sm4FiyCZFxuz0Ifz_Pw',
    appId: '1:54251147633:ios:6ae2fc958ad64cf52026d0',
    messagingSenderId: '54251147633',
    projectId: 'wedding-rental-595ab',
    storageBucket: 'wedding-rental-595ab.appspot.com',
    androidClientId: '54251147633-2riv42ti51vllkt5d62rjn87v9sb0qij.apps.googleusercontent.com',
    iosClientId: '54251147633-p4crssuse3fhqnrgu5q3htvblidge46m.apps.googleusercontent.com',
    iosBundleId: 'com.example.serveMate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQLZkgMkITZnC0sm4FiyCZFxuz0Ifz_Pw',
    appId: '1:54251147633:ios:6ae2fc958ad64cf52026d0',
    messagingSenderId: '54251147633',
    projectId: 'wedding-rental-595ab',
    storageBucket: 'wedding-rental-595ab.appspot.com',
    androidClientId: '54251147633-2riv42ti51vllkt5d62rjn87v9sb0qij.apps.googleusercontent.com',
    iosClientId: '54251147633-p4crssuse3fhqnrgu5q3htvblidge46m.apps.googleusercontent.com',
    iosBundleId: 'com.example.serveMate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBkionTEdMEkpjW0JZsBY1MCLku2S3gCHU',
    appId: '1:54251147633:web:09b25560aa177f232026d0',
    messagingSenderId: '54251147633',
    projectId: 'wedding-rental-595ab',
    authDomain: 'wedding-rental-595ab.firebaseapp.com',
    storageBucket: 'wedding-rental-595ab.appspot.com',
  );
}
