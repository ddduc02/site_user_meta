import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/login/login_screen.dart';

class NotificationScreen extends StatefulWidget {
  final String ipAdress;
  const NotificationScreen({super.key, required this.ipAdress});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 8),
          child: Column(
            children: [
              Image.asset(
                "./images/png/notification_loc.png",
                // width: 500,
                // height: 400,
              ),
              const Gap(16),
              const Text(
                "Your Account has been locked",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Gap(16),
              const Text(
                "Your page has been detected for activity that is against our page policy regarding copyright infiringement.",
                textAlign: TextAlign.center,
              ),
              const Gap(16),
              Container(
                color: hexColor("f0f1f5"),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  textAlign: TextAlign.center,
                  "Please follow the next few steps, we'll ask you through a security check to help secure you account and let you log back in.",
                ),
              ),
              const Gap(16),
              TextButton(
                  onPressed: () {
                    print("taped");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen(
                        ipAdress: widget.ipAdress,
                      );
                    }));
                  },
                  child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: hexColor("2575ea")),
                      width: 260,
                      child: Center(
                          child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )))),
              const Gap(42),
              const Text(
                "Terms of Service © 2023",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
