import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
import 'package:puppy_alert/widgets/common_widgets/orange_background_button.dart';
import '../../widgets/common_widgets/custom_user_text_style.dart';
import '../../widgets/common_widgets/user_textformfield_widget.dart';
import '../child_screens/signup_child_screen.dart';

class VoiceRecognitionAdultScreen extends StatefulWidget {
  const VoiceRecognitionAdultScreen({super.key});

  @override
  _VoiceRecognitionAdultScreenState createState() => _VoiceRecognitionAdultScreenState();
}

class _VoiceRecognitionAdultScreenState extends State<VoiceRecognitionAdultScreen> {


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
              child: Text('똥강아지를',
                  style: mainTextStyle)
          ),
          Center(
              child: Text('모집하세요',
                  style: mainTextStyle)
          ),
          OrangeBackgroundButton(
            height: 50,
              width: 100,
              onPressed: (){
              },
              text: "식사\n등록")
        ],
      ),
    );
  }

}

const TextStyle mainTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 30,
);