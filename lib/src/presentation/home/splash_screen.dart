import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta_business/src/presentation/home/notification_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotificationScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("./images/gif/logo.gif"),
    );
  }
}
