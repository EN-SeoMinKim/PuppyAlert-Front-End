import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/screens/adult_screens/food_registration_completion_adult_screen.dart';
import 'package:puppy_alert/utils/constants.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import 'package:puppy_alert/widgets/adult_widgets/speech_recognition_button_adult_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import 'my_page_adult_screen.dart';

class SpeechRecognitionAdultScreen extends StatefulWidget {
  final UserModel _userDto;

  const SpeechRecognitionAdultScreen({super.key, required userDto})
      : _userDto = userDto;

  @override
  State<SpeechRecognitionAdultScreen> createState() =>
      _SpeechRecognitionAdultScreenState();
}

class _SpeechRecognitionAdultScreenState
    extends State<SpeechRecognitionAdultScreen> {
  late ButtonStatus _status;
  late final FlutterTts _flutterTts;
  late final stt.SpeechToText _speech;
  late String _food;
  late String _time;
  late String _topText;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _status = ButtonStatus.idle;
    _flutterTts = FlutterTts();
    _speech = stt.SpeechToText();
    _topText = '똥강아지를\n모집하세요';
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _timer?.cancel();
    _speech.stop();
    super.dispose();
  }

  Future<void> _speakAndRecognizeFood() async {
    setState(() {
      _food = '';
      _time = '';
      _topText = '등록하실 메뉴를 \n말씀해 주세요';
    });

    await _requestPermission();
    await _initializeTts();
    await _flutterSpeakRequest('등록하실 메뉴를 \n말씀해 주세요');
    await _delayedInitializeAndStartListening(() async {
      _startListening(_food);
    });

    await _endListeningAndVerify(() async {
      await _verify(_food, '말씀하신 메뉴가 \n$_food 인가요?');
    });
  }

  Future<void> _flutterSpeakRequest(String text) async {
    setState(() {
      _status = ButtonStatus.awaitingInput;
      _topText = text;
    });
    await _flutterTts.speak(text);
  }

  Future<void> _delayedInitializeAndStartListening(
      Future<void> Function() startListening) async {
    return Future.delayed(const Duration(seconds: 3), () async {
      await _speech.initialize();
      await startListening();
    });
  }

  void _startListeningState() {
    setState(() {
      _status = ButtonStatus.listening;
      _topText = '';
    });
  }

  Future<void> _startListening(String recognizedText) async {
    _startListeningState();
    await _speech.listen(
      onResult: (result) {
        setState(() {
          if (recognizedText == _food) {
            _food = result.recognizedWords;
          } else if (recognizedText == _time) {
            _time = result.recognizedWords;
          }
        });
      },
    );
  }

  Future<void> _endListening() async {
    _timer = Timer(const Duration(seconds: 5), () async {
      await _speech.stop();
    });
  }


  Future<void> _endListeningAndVerify(Future<void> Function() verify) async {
    _timer = Timer(const Duration(seconds: 5), () async {
      await _speech.stop();
      await verify();
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.status;

    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage('ko');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
  }

  Future<void> _verify(String recognizedText, String confirmationText) async {
    if (recognizedText.isNotEmpty) {
      await _flutterTts.speak(confirmationText);
      setState(() {
        if (recognizedText == _food) {
          _status = ButtonStatus.foodInputCompleted;
        } else if (recognizedText == _time) {
          _status = ButtonStatus.timeInputCompleted;
        }
        _topText = confirmationText;
      });
      return;
    }
    await _handleFailedRecognition(
        '인식된 음성이 없습니다. 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.', '인식된 음성이 없습니다');
  }

  Future<void> _speakAndRecognizeTime() async {
    await _flutterSpeakRequest('식사를 같이 하실\n시간을 말씀해 주세요');
    await _delayedInitializeAndStartListening(() async {
      _startListening(_time);
    });
    await _endListeningAndVerify(() async {
      await _verify(_time, '말씀하신 시간이 \n$_time 인가요?');
    });
  }

  Future<void> _completeRegisterFood() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FoodRegistrationCompletionAdultScreen(
            userId: widget._userDto.userId, food: _food, time: _time)));
  }

  Future<void> _handleFailedRecognition(
      String speakText, String topText) async {
    await _flutterTts.speak(speakText);
    setState(() {
      _status = ButtonStatus.idle;
      _topText = topText;
    });
  }

  Future<void> _clickNoButtonRecognitionFailure() async {
    await _handleFailedRecognition(
        '  식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요', '식사등록 버튼을 누르고\n처음부터 다시 말씀해 주세요');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              if (_topText.isNotEmpty)
                Center(
                  child: Text(
                    _topText,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
              SpeechRecognitionButtonAdultWidget(
                  status: _status,
                  speakAndRecognizeFood: _speakAndRecognizeFood,
                  speakAndRecognizeTime: _speakAndRecognizeTime,
                  clickNoButtonRecognitionFailure:
                      _clickNoButtonRecognitionFailure,
                  completeRegisterFood: _completeRegisterFood),
              ElevatedShadowButtonAdultWidget(
                width: 190,
                text: "나의 정보",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyPageAdultScreen(userDto: widget._userDto,)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
