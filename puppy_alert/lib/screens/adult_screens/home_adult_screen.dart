import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_adult_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';

class HomeAdultScreen extends StatefulWidget {
  final UserDto _userDto;

  const HomeAdultScreen({super.key, required userDto}) :_userDto = userDto;

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
          const SizedBox(
            height: 50,
          ),
          const Center(
              child: Text('똥강아지를\n모집하세요',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30))),
          const SizedBox(
            height: 30,
          ),
          ElevatedShadowButtonAdultWidget(
              height: 150,
              backgroundColor: const Color(0xffFF7700),
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return SpeechRecognitionAdultScreen(userDto: widget._userDto,);
                }));
              },
              text: "식사\n등록"),
          ElevatedShadowButtonAdultWidget(onPressed: () {}, text: "나의 정보"),
        ],
      ),
    );
  }
}
