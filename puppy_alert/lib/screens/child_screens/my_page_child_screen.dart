import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/screens/child_screens/food_detail_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/food_record_screen.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import 'package:puppy_alert/screens/common_screens/personal_information_screen.dart';
import 'package:puppy_alert/widgets/child_widgets/profile_info_button_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/my_page_header_common_widget.dart';
import 'package:http/http.dart' as http;

class MyPageChildScreen extends StatelessWidget {
  final UserModel _userDto;

  const MyPageChildScreen({super.key, required UserModel userDto})
      : _userDto = userDto;

  Future<FoodModel?> _getAppliedFoodModel() async {
    Uri uri = Uri.parse(
        '${dotenv.get('BASE_URL')}/puppy/history?puppyId=${_userDto.userId}');
    final data = jsonDecode(utf8.decode((await http.get(uri)).bodyBytes));
    final now = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()).split('T')[0];

    for (var food in data) {
      String time = food['localDateTime'].toString().split('T')[0];
      if (time == now) {
        return FoodModel(
          address: food['address'],
          addressDetail: food['detailAddress'],
          foodId: food['foodId'],
          hostId: food['partnerId'],
          hostNickName: food['partnerNickName'],
          imageURL: food['imageURL'],
          locationMap: food['location'],
          menu: food['menuName'],
          status: "Matched",
          time: food['localDateTime'],
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPageHeaderCommonWidget(userModel: _userDto,),
        ProfileInfoButtonChildWidget(
            icon: Icons.manage_accounts,
            text: '   개인 정보',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalInformationScreen(
                        userDto: _userDto,
                      )));
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
            onPressed: () async {
              FoodModel? foodModel = await _getAppliedFoodModel();
              if (foodModel == null) {
                print("아직 오늘의 집밥이 없습니다.");
                return;
              }

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodDetailChildScreen(
                      userId: _userDto.userId,
                      foodCommonWidget: FoodCommonWidget(
                        userId: _userDto.userId,
                        foodModel: foodModel,
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
