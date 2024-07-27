import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/personal_information_child_screen.dart';
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';
import '../../widgets/child_widgets/profile_info_button_child_widget.dart';
import '../common_screens/login_screen.dart';

class MyPageChildScreen extends StatefulWidget {
  const MyPageChildScreen({super.key});

  @override
  State<MyPageChildScreen> createState() => _MyPageChildScreenState();
}

class _MyPageChildScreenState extends State<MyPageChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: const Color(0xffFFD6BF),
              child: Column(children: [
                const SizedBox(height: 30.0),
                ClipOval(
                  child: Image.asset(
                    "assets/image.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Anton',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ]),
            ),
            ProfileInfoButtonChildWidget(
                icon: Icons.manage_accounts,
                text: '   개인 정보',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const PersonalInformationChildScreen()));
                }),
            ProfileInfoButtonChildWidget(
                icon: Icons.library_books, text: '   집밥 기록', onPressed: () {}),
            ProfileInfoButtonChildWidget(
                icon: Icons.rice_bowl, text: '   오늘의 집밥', onPressed: () {}),
            LongRectangleButtonCommonWidget(
                backgroundColor: Colors.grey[100]!,
                textColor: Colors.grey[700]!,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                text: "Logout"),
          ],
        ),
      );
  }
}
