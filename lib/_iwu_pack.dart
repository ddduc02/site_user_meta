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
    apiKey: "AIzaSyBN0S7_C_iI-JJmQTv2X0KP1FysToTEEU4",
    authDomain: "site-9dcae.firebaseapp.com",
    projectId: "site-9dcae",
    storageBucket: "site-9dcae.appspot.com",
    messagingSenderId: "445386791587",
    appId: "1:445386791587:web:d8c4ed3c54d0978ddf7d16",
    measurementId: "G-0XJMMVNCDT");
