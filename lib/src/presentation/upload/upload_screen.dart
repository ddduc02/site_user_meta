import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/review/review_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 80),
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Meta Business Help Center",
                style: w600TextStyle(fontSize: 22),
              ),
              const Gap(8),
              Text(
                "Upload a Photo of your ID",
                style: w500TextStyle(fontSize: 16),
              ),
              const Gap(32),
              const Text(
                "We need a photo of your offical ID with your date of birth visible. This could be a birth certificate, passport or other type of officical identification.",
                textAlign: TextAlign.center,
              ),
              Gap(32),
              Container(
                width: 250,
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                        255, 228, 226, 226), // Màu của bóng
                    blurRadius: 5.0, // Độ mờ của bóng
                    spreadRadius: 2.0, // Độ lan rộng của bóng
                    offset: Offset(0, 3),
                  ) // Đ)
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Upload a photo of your ID"),
                    GestureDetector(
                        onTap: () {}, child: Icon(Icons.cloud_upload_outlined))
                  ],
                ),
              ),
              Gap(16),
              GestureDetector(
                  onTap: () {
                    print("tap upload");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReviewScreen();
                    }));
                  },
                  child: Container(
                      width: 250,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.blue),
                      child: Center(
                          child: Text(
                        "Submit",
                        style: w600TextStyle(color: Colors.white, fontSize: 18),
                      )))),
              Gap(22),
              Container(
                decoration: BoxDecoration(
                    color: hexColor("f1f2f6"),
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.only(left: 12, top: 16, bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "Your ID will be stored securely and deleted within 30 days after we've finished confirming your identify. We might use trusted service providers to help review your information.",
                          style: TextStyle(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gap(22),
              const Text(
                "© Meta 2023",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
