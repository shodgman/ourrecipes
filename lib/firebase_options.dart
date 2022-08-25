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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCnhctENtIJnEyef09K3PeZdv2VSuM4UUQ',
    appId: '1:963868862254:web:e356c08d7f82f560e0fcbf',
    messagingSenderId: '963868862254',
    projectId: 'our-shared-recipes',
    authDomain: 'our-shared-recipes.firebaseapp.com',
    storageBucket: 'our-shared-recipes.appspot.com',
    measurementId: 'G-2W0FS4TSSX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChn71ApTgCG_EPaTf0RVqcnLpKgzZ2fH8',
    appId: '1:963868862254:android:fe2a12bc87ee5836e0fcbf',
    messagingSenderId: '963868862254',
    projectId: 'our-shared-recipes',
    storageBucket: 'our-shared-recipes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_SXv1y3uRW3uyt3MCsR__3s1LvesIEg4',
    appId: '1:963868862254:ios:ffdf1c41dac2efa8e0fcbf',
    messagingSenderId: '963868862254',
    projectId: 'our-shared-recipes',
    storageBucket: 'our-shared-recipes.appspot.com',
    iosClientId: '963868862254-pnrg7k7p7h6e09ho6kru1s26n9b43lhn.apps.googleusercontent.com',
    iosBundleId: 'hodgman.id.au.ourrecipes',
  );
}
