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
    apiKey: 'AIzaSyB11UaxT1x05uwDK8S40fJUz4mxI6Rcvts',
    appId: '1:167873227013:web:7ecef7d7cbf641fbd7ef6c',
    messagingSenderId: '167873227013',
    projectId: 'onban-e3465',
    authDomain: 'onban-e3465.firebaseapp.com',
    storageBucket: 'onban-e3465.appspot.com',
    measurementId: 'G-XWE6JJSH6D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQ9uewOwAFKlykNOSD5z1rDs4IaDIcFnE',
    appId: '1:167873227013:android:4faac9593dbecca1d7ef6c',
    messagingSenderId: '167873227013',
    projectId: 'onban-e3465',
    storageBucket: 'onban-e3465.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaH5HKJsEUA1xducnyz-A8HtQlQNxqzBI',
    appId: '1:167873227013:ios:84a567e09f52093cd7ef6c',
    messagingSenderId: '167873227013',
    projectId: 'onban-e3465',
    storageBucket: 'onban-e3465.appspot.com',
    iosBundleId: 'com.example.flutterApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaH5HKJsEUA1xducnyz-A8HtQlQNxqzBI',
    appId: '1:167873227013:ios:87eed7265ee94ef1d7ef6c',
    messagingSenderId: '167873227013',
    projectId: 'onban-e3465',
    storageBucket: 'onban-e3465.appspot.com',
    iosBundleId: 'com.example.flutterApplication.RunnerTests',
  );
}