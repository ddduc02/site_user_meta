import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: _paddingHorizontal(context), vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            children: [
              Text(
                "English (US)",
                style: w300TextStyle(),
              ),
              Gap(16),
              Text(
                "Čeština",
                style: w300TextStyle(),
              ),
              Gap(16),
              Text(
                "Norsk (bokmål)",
                style: w300TextStyle(),
              ),
              Gap(16),
              Text(
                "Nederlands",
                style: w300TextStyle(),
              ),
              Gap(16),
            ],
          ),
          Divider(),
          Wrap(
            spacing: 16,
            children: [
              Text(
                "Signup",
                style: w300TextStyle(),
              ),
              Text(
                "Log in",
                style: w300TextStyle(),
              ),
              Text(
                "Messenger",
                style: w300TextStyle(),
              ),
              Text(
                "Facebook Lite",
                style: w300TextStyle(),
              ),
              Text(
                "Video",
                style: w300TextStyle(),
              ),
              Text(
                "Signup",
                style: w300TextStyle(),
              ),
              Text(
                "Places",
                style: w300TextStyle(),
              ),
              Text(
                "Games",
                style: w300TextStyle(),
              ),
              Text(
                "Marketplace",
                style: w300TextStyle(),
              ),
              Text(
                "Meta Pay",
                style: w300TextStyle(),
              ),
              Text(
                "Meta Store",
                style: w300TextStyle(),
              ),
              Text(
                "Meta Quest",
                style: w300TextStyle(),
              ),
              Text(
                "Instagram",
                style: w300TextStyle(),
              ),
              Text(
                "Threads",
                style: w300TextStyle(),
              ),
              Text(
                "Fundraisers",
                style: w300TextStyle(),
              ),
              Text(
                "Services",
                style: w300TextStyle(),
              ),
              Text(
                "Meta Quest",
                style: w300TextStyle(),
              ),
              Text(
                "Instagram",
                style: w300TextStyle(),
              ),
              Text(
                "Threads",
                style: w300TextStyle(),
              ),
              Text(
                "Fundraisers",
                style: w300TextStyle(),
              ),
              Text(
                "Services",
                style: w300TextStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _paddingHorizontal(BuildContext context) {
    if (context.width > 1280) {
      return 164;
    } else if (context.width > 1024) {
      return 128;
    } else if (context.width > 720) {
      return 64;
    } else {
      return 32;
    }
  }
  // context.width > 1024 ? 190 : 32;
}
