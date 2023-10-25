import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: double.infinity,
      color: hexColor("4067b3"),
      child: Row(
        mainAxisAlignment: screenWidth > 780
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          Text(
            "facebook",
            style: w500TextStyle(fontSize: 32, color: Colors.white),
          ),
          screenWidth > 780
              ? TextButton(
                  onPressed: () {},
                  child: Text(
                    "Log out",
                    style: w600TextStyle(color: Colors.white),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
