import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/food_detail_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/food_record_screen.dart';
import 'package:puppy_alert/screens/common_screens/personal_information_screen.dart';
import 'package:puppy_alert/widgets/common_widgets/my_page_header_common_widget.dart';
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
    return Column(
      children: [
        const MyPageHeaderCommonWidget(imagePath: 'assets/image.png', userName: 'Anton'),
        ProfileInfoButtonChildWidget(
            icon: Icons.manage_accounts,
            text: '   개인 정보',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      const PersonalInformationScreen()));
            }),
        ProfileInfoButtonChildWidget(
            icon: Icons.library_books,
            text: '   집밥 기록',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FoodRecordScreen(isChildScreen: true)));
            }),
        ProfileInfoButtonChildWidget(
            icon: Icons.rice_bowl, text: '   오늘의 집밥',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FoodDetailChildScreen(canRegister: false)));
            }),
        LongRectangleButtonCommonWidget(
            backgroundColor: Colors.grey[100]!,
            textColor: Colors.grey[700]!,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false);
            },
            text: "Logout"),
      ],
    );
  }
}
