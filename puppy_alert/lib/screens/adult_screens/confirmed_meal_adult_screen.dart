import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button.dart';

class ConfirmedMealAdultScreen extends StatefulWidget {
  const ConfirmedMealAdultScreen({super.key});

  @override
  _ConfirmedMealAdultScreenState createState() => _ConfirmedMealAdultScreenState();
}

class _ConfirmedMealAdultScreenState extends State<ConfirmedMealAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(child: Text('똥강아지\n모집완료!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Colors.red,
              ))),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0), // 원하는 둥근 사각형의 반지름 설정
            child: Image.asset(
              'food.png', // 이미지 경로
              width: 150, // 이미지 너비
              height: 150, // 이미지 높이
              fit: BoxFit.cover, // 이미지가 사각형에 맞게 자동 조정되도록 설정
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '비빔밥\n 18:00',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          ElevatedShadowButton(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {},
              text: "취소"),
        ],
      ),
    );
  }
}


