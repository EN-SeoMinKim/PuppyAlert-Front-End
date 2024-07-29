import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/screens/common_screens/food_record_screen.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import 'package:puppy_alert/screens/common_screens/personal_information_screen.dart';
import 'package:puppy_alert/widgets/child_widgets/profile_info_button_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/my_page_header_common_widget.dart';

class MyPageChildScreen extends StatefulWidget {
  final UserDto _userDto;

  const MyPageChildScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  State<MyPageChildScreen> createState() => _MyPageChildScreenState();
}

class _MyPageChildScreenState extends State<MyPageChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPageHeaderCommonWidget(imagePath: 'assets/image.png', userName: widget._userDto.nickName),
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
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) =>
              //         FoodDetailChildScreen(canRegister: false)));
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
