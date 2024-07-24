import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_adult_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button.dart';

class HomeAdultScreen extends StatefulWidget {
  const HomeAdultScreen({super.key});

  @override
  State<HomeAdultScreen> createState() => _HomeAdultScreenState();
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
          Center(
              child: Text('똥강아지를\n모집하세요',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30))),
          SizedBox(
            height: 30,
          ),
          ElevatedShadowButton(
              height: 150,
              backgroundColor: Color(0xffFF7700),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SpeechRecognitionAdultScreen()));
              },
              text: "식사\n등록"),
          ElevatedShadowButton(onPressed: () {}, text: "나의 정보"),
        ],
      ),
    );
  }
}
