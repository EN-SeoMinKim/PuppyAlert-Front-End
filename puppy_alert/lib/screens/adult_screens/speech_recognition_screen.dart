import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:puppy_alert/screens/adult_screens/zipbob_registration_completion_adult_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import '../../widgets/adult_widgets/elevated_shadow_button.dart';
import 'mypage_adult_screen.dart';

class SpeechRecognitionScreen extends StatefulWidget {
  const SpeechRecognitionScreen({super.key});

  @override
  State<SpeechRecognitionScreen> createState() =>
      _SpeechRecognitionScreenState();
}

class _SpeechRecognitionScreenState extends State<SpeechRecognitionScreen> {
  late final FlutterTts _flutterTts;
  late final stt.SpeechToText _speech;
  late String _menu;
  late String _time;
  late String _feedbackText;
  late String _topText;
  late bool _isListening;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _speech = stt.SpeechToText();
    _feedbackText = '';
    _topText = '똥강아지를\n모집하세요';
    _isListening = false;
  }

  Future<void> speakAndRecognize() async {
    setState(() {
      _menu = '';
      _time = '';
      _feedbackText = '';
      _topText = '등록하실 메뉴를 \n말씀해 주세요';
    });

    await _flutterTts.setLanguage('ko');
    await _flutterTts.speak('등록하실 메뉴를 말씀해 주세요');
    await _getZipbobMenu();
    await _getZipbobTime();
    await navigateToZipbobRegistrationCompleteScreen();
  }

  Future<void> navigateToZipbobRegistrationCompleteScreen() {
    return Future.delayed(Duration(seconds: 25), ()  {
      if(_menu.isNotEmpty && _time.isNotEmpty){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ZipbobRegistrationCompletionAdultScreen()));
      }
    });
  }


  Future<void> _getZipbobMenu() {
    return Future.delayed(Duration(seconds: 3), () async {
      await _initializeSpeech();
      if (_isListening) {
        await _startListeningMenu();
      }
    });
  }

  Future<void> _getZipbobTime() async {
    return Future.delayed(Duration(seconds: 18), () async {
      if (_menu.isNotEmpty) {
        setState(() {
          _topText = '식사를 같이 하실 \n시간을 말씀해 주세요';
          _feedbackText = '';
        });
        await _flutterTts.speak('식사를 같이 하실 시간을 말씀해 주세요');
        await _initializeSpeech();
        if(_isListening){
          await _startListeningTime();
        }
      }
    });
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(onError: (error) {
      setState(() {
        _isListening = false;
        _feedbackText = 'Error가 발생했습니다.';
      });
    });

    if (available) {
      setState(() {
        _isListening = true;
      });
    } else {
      setState(() {
        _isListening = false;
        _feedbackText = '음성 인식 기능이 사용 불가능합니다.';
      });
    }
  }

  Future<void> _startListeningMenu() async {
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _topText = '';
          _menu = result.recognizedWords;
        });
      },
    );

    _timer = Timer(Duration(seconds: 6), () async {
      if (_isListening) {
        await _speech.stop();
        setState(() {
          _isListening = false;
          _topText = '';
        });
        verifyMenu();
      }
    });
  }

  Future<void> verifyMenu() async {
    if (_menu.isNotEmpty) {
      await _flutterTts.speak(
          '말씀하신 메뉴가 $_menu 인가요? 맞다면 잠시만 기다려주시고 아니면 식사등록 버튼을 누르고 메뉴를 다시 한번 말씀해 주세요.');
      setState(() {
        _feedbackText = '말씀하신 메뉴가 \n$_menu 인가요? ';
      });
      print('등록 메뉴: $_menu');
    } else {
      await _flutterTts.speak('인식된 음성이 없습니다. 식사등록 버튼을 누르고 메뉴를 다시 한번 말씀해 주세요.');
      setState(() {
        _feedbackText = '인식된 음성이 없습니다.';
      });
      print('등록 메뉴: No speech detected');
    }
  }

  Future<void> _startListeningTime() async {
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _time = result.recognizedWords;
        });
      },
    );

    _timer = Timer(Duration(seconds: 7), () async {
      if (_isListening) {
        await _speech.stop();
        setState(() {
          _isListening = false;
          _topText = '';
        });
        verifyTime();
      }
    });
  }

  Future<void> verifyTime() async {
    if (_time.isNotEmpty) {
      await _flutterTts.speak(
          '말씀하신 시간이 $_time 인가요? 맞다면 잠시만 기다려주시고 아니면 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.');
      setState(() {
        _feedbackText = '말씀하신 시간이 \n$_time 인가요?';
      });
      print('등록 시간: $_time');
    } else {
      await _flutterTts.speak('인식된 음성이 없습니다. 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.');
      setState(() {
        _feedbackText = '인식된 음성이 없습니다.';
      });
      print('등록 시간: No speech detected');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _flutterTts.stop();
    if(_isListening){
      _speech.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            _flutterTts.stop();
            _timer?.cancel();
            if(_isListening){
              _speech.stop();
            }

          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_topText.isNotEmpty)
              Center(
                child: Text(
                  _topText,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
            Center(
                child: Text(_feedbackText,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w900))),
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
                    child: _isListening
                        ? Icon(
                            Icons.mic,
                            size: 80,
                            color: Colors.white,
                          )
                        : Text(
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
