import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:puppy_alert/screens/adult_screens/mypage_adult_screen.dart';
import '../../service/speech_service.dart';
import '../../widgets/adult_widgets/elevated_shadow_button.dart';

class SpeechRecognitionScreen extends StatefulWidget {
  @override
  _SpeechRecognitionScreenState createState() =>
      _SpeechRecognitionScreenState();
}

class _SpeechRecognitionScreenState extends State<SpeechRecognitionScreen> {
  late SpeechService _speechService;
  String _recognizedText = 'Press the button and start speaking';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechService = SpeechService();
    _speechService.initSpeech();
  }

  @override
  void dispose() {
    _speechService.stopListening();
    super.dispose();
  }

  void _toggleListening() {
    if (!_isListening) {
      _speechService.startListening(
        onResult: (text) {
          setState(() {
            _recognizedText = text;
          });
        },
        onError: (error) {
          print('Error: $error');
        },
        onStatus: (isListening) {
          setState(() {
            _isListening = isListening;
          });
        },
        localeId: 'ko_KR',
      );
    } else {
      _speechService.stopListening();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text('똥강아지를\n모집하세요',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ))),
            AvatarGlow(
              animate: _isListening,
              glowColor: Color(0xffFF7700),
              endRadius: 150.0,
              duration: Duration(milliseconds: 2000),
              repeatPauseDuration: Duration(milliseconds: 100),
              repeat: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 180.0,
                  minHeight: 150.0,
                ),
                child: FloatingActionButton(
                    backgroundColor: Color(0xffFF7700),
                    onPressed: _toggleListening,
                    child: Text(
                      "식사\n등록",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.white,
                        letterSpacing: 3.0,
                      ),
                    )),
              ),
            ),
            ElevatedShadowButton(
              text: "나의 정보",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MypageAdultScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
