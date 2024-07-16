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
          Center(child: Text('똥강아지\n모집완료',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Colors.red,
              ))),
          SizedBox(
            height: 30,
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


