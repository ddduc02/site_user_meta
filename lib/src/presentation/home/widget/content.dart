import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:meta_business/src/presentation/home/widget/personal.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int indexPage = 0; // Nội dung ban đầu
  void updateContent(int index) {
    setState(() {
      indexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexColor('fffbf2'),
        hexColor('f2f8fe'),
      ])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (screenWidth >= 1280) ...{
            SideBar(),
            _getContent(indexPage),
          } else ...{
            _getContent(indexPage),
          }
          // PersonalWidget(),
        ],
      ),
    );
  }

  Widget SideBar() {
    return Container(
        width: 500,
        height: 700,
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
          color: hexColor('e7e7e4'),
          width: 2,
        ))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Account Center',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Gap(12),
          Text(
            'We have received multiple reports that suggest that your account has been in violation of our terms of service and  community guidelines. As a result, your account is scheduled for review.',
            style: w300TextStyle(
              height: 1.4,
              fontSize: 18,
            ),
          ),
          const Gap(8),
          const Text(
            'Learn more',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
          const Gap(16),
          const Text(
            'Account Setting',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Gap(12),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: indexPage == 0 ? hexColor('344854') : null),
            child: ListTile(
              leading: Icon(Icons.person,
                  color: indexPage == 0 ? Colors.white : Colors.black),
              title: Text(
                'Personal Details',
                style: TextStyle(
                    fontSize: 20,
                    color: indexPage == 0 ? Colors.white : Colors.black),
              ),
              onTap: () {
                updateContent(0);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: indexPage == 1 ? hexColor('344854') : null),
            child: ListTile(
              leading: Icon(Icons.security,
                  color: indexPage == 1 ? Colors.white : Colors.black),
              title: Text(
                'Password and security',
                style: TextStyle(
                    fontSize: 20,
                    color: indexPage == 1 ? Colors.white : Colors.black),
              ),
              onTap: () {
                updateContent(1);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: indexPage == 2 ? hexColor('344854') : null),
            child: ListTile(
              leading: Icon(Icons.rule,
                  color: indexPage == 2 ? Colors.white : Colors.black),
              title: Text(
                'Permissions',
                style: TextStyle(
                    fontSize: 20,
                    color: indexPage == 2 ? Colors.white : Colors.black),
              ),
              onTap: () {
                updateContent(2);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: indexPage == 3 ? hexColor('344854') : null),
            child: ListTile(
              leading: Icon(Icons.tv,
                  color: indexPage == 3 ? Colors.white : Colors.black),
              title: Text(
                'Ad preferences',
                style: TextStyle(
                    fontSize: 20,
                    color: indexPage == 3 ? Colors.white : Colors.black),
              ),
              onTap: () {
                updateContent(3);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: indexPage == 4 ? hexColor('444854') : null),
            child: ListTile(
              leading: Icon(Icons.wallet,
                  color: indexPage == 4 ? Colors.white : Colors.black),
              title: Text(
                'Payments',
                style: TextStyle(
                    fontSize: 20,
                    color: indexPage == 4 ? Colors.white : Colors.black),
              ),
              onTap: () {
                updateContent(4);
              },
            ),
          ),
        ]));
  }
}

Widget _getContent(int index) {
  switch (index) {
    case 0:
      return const PersonalWidget();
    case 1:
      return const PersonalWidget();
    default:
      return const PersonalWidget();
  }
}
