import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:puppy_alert/widgets/host_widgets/speech_recognition_button_host_widget.dart';
import 'package:puppy_alert/widgets/host_widgets/top_white_container_host_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../utils/constants.dart';
import 'food_registration_completion_host_screen.dart';

class SpeechRecognitionHostScreen extends StatefulWidget {
  final String _userId;

  const SpeechRecognitionHostScreen({super.key, required userId})
      : _userId = userId;

  @override
  State<SpeechRecognitionHostScreen> createState() =>
      _NewSpeechRecognitionHostScreen();
}

class _NewSpeechRecognitionHostScreen
    extends State<SpeechRecognitionHostScreen> {
  late ButtonStatus _status;
  late final FlutterTts _flutterTts;
  late final stt.SpeechToText _speech;
  late String _food, _time, _topText;
  late Timer? _timer = null;

  @override
  void initState() {
    super.initState();
    _status = ButtonStatus.idle;
    _flutterTts = FlutterTts();
    _speech = stt.SpeechToText();
    _topText = '식사 등록 버튼을\n     눌러주세요';
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
      _topText = '등록하실 메뉴를 \n  말씀해 주세요';
    });

    await _requestPermission();
    await _initializeTts();
    await _flutterSpeakRequest('등록하실 메뉴를 \n  말씀해 주세요');
    await _delayedInitializeAndStartListening(() async {
      _startListening(_food);
    });

    await _endListeningAndVerify(() async {
      await _verify(_food, '말씀하신 메뉴가 \n$_food 인가요?');
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

  void _startListeningState() {
    setState(() {
      _status = ButtonStatus.listening;
      _topText = '';
    });
  }

  Future<void> _endListeningAndVerify(Future<void> Function() verify) async {
    _timer = Timer(const Duration(seconds: 5), () async {
      await _speech.stop();
      await verify();
    });
  }

  Future<void> _verify(String recognizedText, String confirmationText) async {
    //if문을 통해 음식이 맞는지 확인을 먼저하자

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

  Future<void> _handleFailedRecognition(
      String speakText, String topText) async {
    await _flutterTts.speak(speakText);
    setState(() {
      _status = ButtonStatus.idle;
      _topText = topText;
    });
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

  Future<void> _clickNoButtonRecognitionFailure() async {
    await _handleFailedRecognition(
        '  식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요', '식사등록 버튼을 누르고\n처음부터 다시 말씀해 주세요');
  }

  Future<void> _completeRegisterFood() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FoodRegistrationCompletionHostScreen(
            userId: widget._userId, food: _food, time: _time)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              TopWhiteContainerHostWidget(text: _topText),
              SpeechRecognitionButtonHostWidget(
                  status: _status,
                  speakAndRecognizeFood: _speakAndRecognizeFood,
                  speakAndRecognizeTime: _speakAndRecognizeTime,
                  clickNoButtonRecognitionFailure:
                      _clickNoButtonRecognitionFailure,
                  completeRegisterFood: _completeRegisterFood)
            ],
          ),
        ),
      ),
    );
  }
}
