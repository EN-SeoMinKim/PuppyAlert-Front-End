import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/voice_recognition_adult_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/grey_background_button.dart';
import 'package:puppy_alert/widgets/common_widgets/orange_background_button.dart';

class HomeAdultScreen extends StatefulWidget {
  const HomeAdultScreen({super.key});

  @override
  _HomeAdultScreenState createState() => _HomeAdultScreenState();
}

class _HomeAdultScreenState extends State<HomeAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(child: Text('똥강아지를\n모집하세요', style: mainTextStyle)),
          SizedBox(
            height: 30,
          ),
          OrangeBackgroundButton(
              height: 150,
              width: 200,
              fontSize: 40,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VoiceRecognitionAdultScreen()));
              },
              text: "식사\n등록"
          ),
          GreyBackgroundButton(
              onPressed: (){

              },
              text: "나의 정보"),
        ],
      ),
    );
  }
}

const TextStyle mainTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 30,
);
