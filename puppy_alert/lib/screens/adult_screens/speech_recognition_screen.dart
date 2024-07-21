import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import '../../widgets/adult_widgets/elevated_shadow_button.dart';
import 'mypage_adult_screen.dart';

class SpeechRecognitionScreen extends StatefulWidget {
  const SpeechRecognitionScreen({super.key});

  @override
  State<SpeechRecognitionScreen> createState() => _SpeechRecognitionScreenState();
}

class _SpeechRecognitionScreenState extends State<SpeechRecognitionScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();

  String recognizedText = '';
  String menu = '';
  String time = '';
  String feedbackText = '';
  String initialPromptText = '똥강아지를\n모집하세요';
  bool _isListening = false;
  Timer? _timer;

  Future<void> speakAndRecognize() async {
    setState(() {
      recognizedText = '';
      feedbackText = '';
      initialPromptText = '등록하실 메뉴를 \n말씀해 주세요';
    });

    await flutterTts.setLanguage('ko');
    await flutterTts.speak('등록하실 메뉴를 말씀해 주세요');

    await _initializeSpeech();
    if (_isListening) {
      await _startListeningMenu();

      Timer(Duration(seconds: 16), () async {
        setState(() {
          initialPromptText = '식사를 같이 하실 \n시간을 말씀해 주세요';
          feedbackText = '';
        });

        await flutterTts.speak('식사를 같이 하실 시간을 말씀해 주세요');
        await _initializeSpeech();
        await _startListeningTime();
      });
      Timer(Duration(seconds: 32), () async {
        if(time.isNotEmpty && menu.isNotEmpty){
          await flutterTts.speak('식사 등록이 완료되었습니다.');
          setState(() {
            feedbackText = '식사 등록이 \n완료되었습니다.';
          });
        }
        else{
          await flutterTts.speak('등록이 완료되지 않았습니다. 식사 등록버튼을 누르고 처음부터 다시 말씀해 주세요.');
          setState(() {
            feedbackText = '식사 등록이 \n완료되지 않았습니다.';
          });
        }

      });
    }

  }


  Future<void> _initializeSpeech() async {
    bool available = await speech.initialize(
      onStatus: (status) {
        print('Speech recognition status: $status');
      },
      onError: (error) {
        print('Speech recognition error: $error');
        setState(() {
          _isListening = false;
          feedbackText = '음성 인식 초기화 오류: $error';
        });
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
      });
    } else {
      print('Speech recognition is not available');
      setState(() {
        feedbackText = '음성 인식 기능이 사용 불가능합니다.';
      });
    }
  }

  Future<void> _startListeningMenu() async {
    await speech.listen(
      onResult: (result) {
        setState(() {
          initialPromptText = '';
          recognizedText = result.recognizedWords;
          menu = result.recognizedWords;
        });
      },
      onSoundLevelChange: (level) {
        print('Sound level: $level');
      },
    );

    _timer = Timer(Duration(seconds: 6), () async {
      if (_isListening) {
        await speech.stop();
        setState(() {
          _isListening = false;
          initialPromptText = '';
        });
        verifyMenu();
      }
    });
  }

  Future<void> speakText(String text) async {
    await flutterTts.speak(text);
  }

  void verifyMenu() async {
    if (menu.isNotEmpty) {
      await speakText('말씀하신 메뉴가 $recognizedText 인가요? 아니면 식사등록 버튼을 누르고 메뉴를 다시 한번 말씀해 주세요.');
      setState(() {
        feedbackText = '말씀하신 메뉴가 \n$recognizedText 인가요? ';
      });

      print('등록 메뉴: $recognizedText');
    } else {
      await speakText('인식된 음성이 없습니다. 식사등록 버튼을 누르고 메뉴를 다시 한번 말씀해 주세요.');
      setState(() {
        feedbackText = '인식된 음성이 없습니다.';
      });

      print('등록 메뉴: No speech detected');
    }
  }

  Future<void> _startListeningTime() async {
    await speech.listen(
      onResult: (result) {
        setState(() {
          recognizedText = result.recognizedWords;
          time = result.recognizedWords;
        });
      },
      onSoundLevelChange: (level) {
        print('Sound level: $level');
      },
    );

    _timer = Timer(Duration(seconds: 6), () async {
      if (_isListening) {
        await speech.stop();
        setState(() {
          _isListening = false;
          initialPromptText = '';
        });
        verifyTime();
      }
    });
  }

  void verifyTime() async {
    if (time.isNotEmpty) {
      await speakText('말씀하신 시간이 $recognizedText 인가요? 아니면 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.');
      setState(() {
        feedbackText = '말씀하신 시간이 \n$recognizedText 인가요?';
      });

      print('등록 시간: $recognizedText');
    } else {
      await speakText('인식된 음성이 없습니다. 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.');
      setState(() {
        feedbackText = '인식된 음성이 없습니다. 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.';
      });

      print('등록 시간: No speech detected');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //     child: Text('똥강아지를\n모집하세요',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w900,
            //           fontSize: 30,
            //         ))),
            if (initialPromptText.isNotEmpty)
              Center(
                child: Text(
                  initialPromptText,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
            Center(child: Text(feedbackText, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900))),
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
                    onPressed: speakAndRecognize,
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
              width: 190,
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
