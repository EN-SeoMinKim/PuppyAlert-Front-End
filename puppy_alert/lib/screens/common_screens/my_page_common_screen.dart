import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/screens/puppy_screens/food_detail_puppy_screen.dart';
import 'package:puppy_alert/screens/common_screens/food_record_common_screen.dart';
import 'package:puppy_alert/screens/common_screens/login_common_screen.dart';
import 'package:puppy_alert/screens/common_screens/personal_information_common_screen.dart';
import 'package:puppy_alert/widgets/puppy_widgets/profile_info_button_puppy_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/my_page_header_common_widget.dart';
import 'package:http/http.dart' as http;

class MyPageCommonScreen extends StatelessWidget {
  final UserModel _userModel;

  const MyPageCommonScreen({super.key, required UserModel userModel})
      : _userModel = userModel;

  Future<FoodModel?> _getAppliedFoodModel() async {
    Uri uri = Uri.parse(
        '${dotenv.get('BASE_URL')}/user/history?puppyId=${_userModel.userId}');
    final data = jsonDecode(utf8.decode((await http.get(uri)).bodyBytes));
    final now = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()).split('T')[0];

    for (var food in data) {  // 오늘의 집밥 찾기 (API 생성 전 임시로 오늘 날짜로 설정)
      String time = food['localDateTime'].toString().split('T')[0];

      if (time == now) {
        return FoodModel.fromJson(food);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPageHeaderCommonWidget(userModel: _userModel,),
        ProfileInfoButtonPuppyWidget(
            icon: Icons.manage_accounts,
            text: '   개인 정보',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalInformationCommonScreen(
                        userModel: _userModel,
                      )));
            }),
        ProfileInfoButtonPuppyWidget(
            icon: Icons.library_books,
            text: '   집밥 기록',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodRecordCommonScreen(
                        isChildScreen: true,
                        userId: _userModel.userId,
                      )));
            }),
        ProfileInfoButtonPuppyWidget(
            icon: Icons.rice_bowl,
            text: '   오늘의 집밥',
            onPressed: () async {
              FoodModel? foodModel = await _getAppliedFoodModel();
              if (foodModel == null) {
                print("아직 오늘의 집밥이 없습니다.");
                return;
              }

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodDetailPuppyScreen(
                      userId: _userModel.userId,
                      foodCommonWidget: FoodCommonWidget(
                        userId: _userModel.userId,
                        foodModel: foodModel,
                      ))));
            }),
        LongRectangleButtonCommonWidget(
            backgroundColor: Colors.grey[100]!,
            textColor: Colors.grey[700]!,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginCommonScreen()),
                  (Route<dynamic> route) => false);
            },
            text: "Logout"),
      ],
    );
  }
}
