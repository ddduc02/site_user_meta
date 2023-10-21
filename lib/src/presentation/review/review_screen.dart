import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 500,
          height: 300,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 60, right: 16, left: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 235, 233, 233), // Màu của đổ bóng
                blurRadius: 10, // Bán kính đổ bóng
                spreadRadius: 2, // Phạm vi đổ bóng
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Submission ID: 123123123123",
                style: w500TextStyle(fontSize: 12),
              ),
              Gap(8),
              Text(
                "In review",
                style: w500TextStyle(fontSize: 18),
              ),
              Gap(12),
              MyStepper(
                title: 'Submission received',
                subtile: 'We received the submission today',
                status: 'done',
              ),
              Gap(16),
              MyStepper(
                title: 'In review',
                subtile:
                    "We're reviewing your submission. Review usually takes 48 hours",
                status: 'onGoing',
              ),
              Gap(16),
              MyStepper(
                title: 'Decision made',
                subtile: "You'll receive an email once we've made a decision",
                status: 'unFinished',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyStepper extends StatelessWidget {
  final String title;
  final String subtile;
  final String status;
  const MyStepper(
      {super.key,
      required this.title,
      required this.subtile,
      required this.status});

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color textColor = hexColor("8b8c92");
    if (status == "done") {
      iconColor = hexColor("848484");
    } else if (status == "onGoing") {
      iconColor = hexColor("3580e8");
      textColor = Color.fromARGB(255, 49, 49, 49);
    } else {
      iconColor = hexColor("8b8c92");
    }
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(color: iconColor, Icons.check_circle_rounded),
                Gap(12),
                Text(
                  title,
                  style: w600TextStyle(fontSize: 16, color: iconColor),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: Text(
                subtile,
                style: TextStyle(color: textColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
