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
    apiKey: 'AIzaSyDoh1RJLBtblr-gLQG5ATHHoDATyX3KU04',
    appId: '1:180380880828:web:da8244e550ee14ffbfe5b9',
    messagingSenderId: '180380880828',
    projectId: 'itec-b5aeb',
    authDomain: 'itec-b5aeb.firebaseapp.com',
    storageBucket: 'itec-b5aeb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUt1fXIo701DMjmHFRmuF3XhKLXeJjuQU',
    appId: '1:180380880828:android:096ac89dad634922bfe5b9',
    messagingSenderId: '180380880828',
    projectId: 'itec-b5aeb',
    storageBucket: 'itec-b5aeb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgk245PN-xRTjd2ViM8KQX-tCIMWVAMek',
    appId: '1:180380880828:ios:481b9e7e2141b18cbfe5b9',
    messagingSenderId: '180380880828',
    projectId: 'itec-b5aeb',
    storageBucket: 'itec-b5aeb.appspot.com',
    iosClientId: '180380880828-924u1rkmt2mr6ms3m6bc8s1g3ajfs8vh.apps.googleusercontent.com',
    iosBundleId: 'com.example.itec20222',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgk245PN-xRTjd2ViM8KQX-tCIMWVAMek',
    appId: '1:180380880828:ios:481b9e7e2141b18cbfe5b9',
    messagingSenderId: '180380880828',
    projectId: 'itec-b5aeb',
    storageBucket: 'itec-b5aeb.appspot.com',
    iosClientId: '180380880828-924u1rkmt2mr6ms3m6bc8s1g3ajfs8vh.apps.googleusercontent.com',
    iosBundleId: 'com.example.itec20222',
  );
}