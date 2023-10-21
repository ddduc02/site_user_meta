import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: hexColor("4067b3"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "facebook",
            style: w800TextStyle(fontSize: 32, color: Colors.white),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Log out",
                style: w600TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
