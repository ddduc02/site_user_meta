import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  WidgetAppSVG(
                    'm6',
                    width: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Meta For Business",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              if (screenWidth >= 1280) ...{
                const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "Advertise",
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "Learn",
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  "Support",
                  style: TextStyle(fontSize: 18),
                ),
              },
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                decoration: BoxDecoration(
                    color: hexColor('344854'),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  "Start Now",
                  style: w500TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 24),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Business Help Center"),
                Text("Get support"),
              ],
            ),
          )
        ],
      ),
    );
  }

  double _paddingHorizontal(BuildContext context) =>
      context.width > 1280 ? (context.width - 1280) / 2 : 16;
}
