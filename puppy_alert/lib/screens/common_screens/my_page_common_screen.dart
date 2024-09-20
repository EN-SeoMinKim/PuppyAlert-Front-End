import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/screens/common_screens/food_detail_common_screen.dart';
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

  Future<FoodModel?> _fetchTodayFood() async {
    http.Response response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/user/day?userId=${_userModel.userId}'));

    if (response.statusCode != 200) {
      return null;
    }

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return FoodModel.fromJson(jsonData);
  }

  void _onPressTodayFood(BuildContext context) async {
    FoodModel? foodModel = await _fetchTodayFood();
    if (foodModel == null || foodModel.status == 'COMPLETE') {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('오늘의 집밥이 존재하지 않습니다.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('확인'))
              ],
            );
          });
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FoodDetailCommonScreen(
            userId: _userModel.userId,
            isPuppyScreen:  _userModel.userId != foodModel.hostId,
            foodCommonWidget: FoodCommonWidget(
              userId: _userModel.userId,
              foodModel: foodModel,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPageHeaderCommonWidget(
          userModel: _userModel,
        ),
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
                        isPuppyScreen: true,
                        userId: _userModel.userId,
                      )));
            }),
        ProfileInfoButtonPuppyWidget(
            icon: Icons.rice_bowl,
            text: '   오늘의 집밥',
            onPressed: () {
              _onPressTodayFood(context);
            }),
        LongRectangleButtonCommonWidget(
            backgroundColor: Colors.grey[100]!,
            textColor: Colors.grey[700]!,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const LoginCommonScreen()),
                  (Route<dynamic> route) => false);
            },
            text: "Logout"),
      ],
    );
  }
}
