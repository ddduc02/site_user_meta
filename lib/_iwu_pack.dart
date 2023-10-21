import 'package:_iwu_pack/setup/app_base.dart';
import 'package:_iwu_pack/setup/app_setup.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/constants/constants.dart';
import 'src/utils/utils.dart';

imagineeringwithusPackSetup() {
  AppSetup.initialized(
    value: AppSetup(
      env: AppEnv.preprod,
      appColors: AppColors.instance,
      appPrefs: AppPrefs.instance,
    ),
  );
}

const FirebaseOptions firebaseOptionsPREPROD = FirebaseOptions(
    apiKey: "AIzaSyD7z6KjKG34OSpph-8-DGeJ1VPD5tuB9eQ",
    authDomain: "meta-123-13027.firebaseapp.com",
    projectId: "meta-123-13027",
    storageBucket: "meta-123-13027.appspot.com",
    messagingSenderId: "151078582916",
    appId: "1:151078582916:web:a514080e41f7ae5e59a0d1",
    measurementId: "G-175Y8F3WST");
