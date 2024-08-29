import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/screens/child_screens/food_detail_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/food_record_screen.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import 'package:puppy_alert/screens/common_screens/personal_information_screen.dart';
import 'package:puppy_alert/widgets/child_widgets/profile_info_button_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/my_page_header_common_widget.dart';

class MyPageChildScreen extends StatelessWidget {
  final UserDto _userDto;

  const MyPageChildScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPageHeaderCommonWidget(userName: _userDto.nickName),
        ProfileInfoButtonChildWidget(
            icon: Icons.manage_accounts,
            text: '   개인 정보',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalInformationScreen(userDto: _userDto,)));
            }),
        ProfileInfoButtonChildWidget(
            icon: Icons.library_books,
            text: '   집밥 기록',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodRecordScreen(
                        isChildScreen: true,
                        userId: _userDto.userId,
                      )));
            }),
        ProfileInfoButtonChildWidget(
            icon: Icons.rice_bowl,
            text: '   오늘의 집밥',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodDetailChildScreen(
                      canRegister: false,
                      allAddress: '군자동 150-14 엔샵빌라 16동 209호',
                      latitude: 37.5537926552335,
                      longitude: 127.07382983231,
                      foodId: 1,
                      recruitmentStatus: 'MATCHED',
                      userId: _userDto.userId,
                      foodCommonWidget: FoodCommonWidget(
                        foodName: '까르보나라',
                        userId: _userDto.userId,
                        recruitmentStatus: 'READY',
                        hostName: 'KwonOhSung',
                        imagePath: 'https://blog.kakaocdn.net/dn/cDOn0y/btruVLrLi88/aXkUtkaXRvdWVqaJv89Jn0/img.jpg',
                        time: '08/01 17:00',
                      ))));
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
