import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
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
    Timer(const Duration(seconds: 4), () async {
      final ipv6 = await Ipify.ipv64();
      print(ipv6);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotificationScreen(
                    ipAdress: ipv6,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("./images/gif/logo.gif"),
    );
  }
}
