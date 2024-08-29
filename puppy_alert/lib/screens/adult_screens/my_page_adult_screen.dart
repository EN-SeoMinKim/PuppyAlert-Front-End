import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/screens/common_screens/food_record_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import '../../widgets/common_widgets/my_page_header_common_widget.dart';
import '../common_screens/login_screen.dart';
import '../common_screens/personal_information_screen.dart';

class MyPageAdultScreen extends StatefulWidget {
  final UserDto _userDto;

  const MyPageAdultScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  State<MyPageAdultScreen> createState() => _MyPageAdultScreenState();
}

class _MyPageAdultScreenState extends State<MyPageAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            MyPageHeaderCommonWidget( userName: widget._userDto.nickName),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PersonalInformationScreen(userDto: widget._userDto,)));
                },
                text: "개인 정보"),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FoodRecordScreen(isChildScreen: false, userId: widget._userDto.userId,)));
                },
                text: "집밥 기록"),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
                width: 200,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false);
                },
                text: "로그 아웃"),
          ],
        ),
      ),
    );
  }
}
