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
    apiKey: 'AIzaSyCTWYm9fx6KCCmea722OiKbeLIJJebCkn4',
    appId: '1:788563707797:web:439d5cabca6a27b87e189c',
    messagingSenderId: '788563707797',
    projectId: 'chat-menager-app',
    authDomain: 'chat-menager-app.firebaseapp.com',
    storageBucket: 'chat-menager-app.firebasestorage.app',
    measurementId: 'G-95DM6X71QR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhKJWK3oVjf-DsLV6fqOhfA20KoIMwtCI',
    appId: '1:788563707797:android:582b40dabb87771f7e189c',
    messagingSenderId: '788563707797',
    projectId: 'chat-menager-app',
    storageBucket: 'chat-menager-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0OurWZ5ohtzoBB_Ty-PMTiW6Etl_150Q',
    appId: '1:788563707797:ios:0455d43da3ada3b37e189c',
    messagingSenderId: '788563707797',
    projectId: 'chat-menager-app',
    storageBucket: 'chat-menager-app.firebasestorage.app',
    iosClientId: '788563707797-39vjj67ipikb9ct6nrdn0jmkkq2o77hf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatMenager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0OurWZ5ohtzoBB_Ty-PMTiW6Etl_150Q',
    appId: '1:788563707797:ios:0455d43da3ada3b37e189c',
    messagingSenderId: '788563707797',
    projectId: 'chat-menager-app',
    storageBucket: 'chat-menager-app.firebasestorage.app',
    iosClientId: '788563707797-39vjj67ipikb9ct6nrdn0jmkkq2o77hf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatMenager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCTWYm9fx6KCCmea722OiKbeLIJJebCkn4',
    appId: '1:788563707797:web:11abf51a818457e87e189c',
    messagingSenderId: '788563707797',
    projectId: 'chat-menager-app',
    authDomain: 'chat-menager-app.firebaseapp.com',
    storageBucket: 'chat-menager-app.firebasestorage.app',
    measurementId: 'G-J89WX745WV',
  );
}
