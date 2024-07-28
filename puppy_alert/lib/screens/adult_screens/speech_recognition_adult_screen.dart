import 'package:avatar_glow/avatar_glow.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:puppy_alert/screens/adult_screens/food_registration_completion_adult_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import '../../utils/constants.dart';
import '../../widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import 'my_page_adult_screen.dart';

class SpeechRecognitionAdultScreen extends StatefulWidget {
  const SpeechRecognitionAdultScreen({super.key});

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
  late String _feedbackText;
  late String _topText;
  late bool _isListening;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _status = ButtonStatus.idle;
    _flutterTts = FlutterTts();
    _speech = stt.SpeechToText();
    _feedbackText = '';
    _topText = '똥강아지를\n모집하세요';
    _isListening = false;
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _timer?.cancel();
    if (_isListening) {
      _speech.stop();
    }
    super.dispose();
  }

  Future<void> speakAndRecognizeFood() async {
    setState(() {
      _food = '';
      _time = '';
      _feedbackText = '';
      _topText = '등록하실 메뉴를 \n말씀해 주세요';
    });

    await _requestPermission();
    await _initializeTts();
    await _flutterTts.speak('등록하실 메뉴를 말씀해 주세요');
    await _delayedInitializeAndStartListening(_startListeningFood);
  }

  Future<void> _requestTime() async {
    setState(() {
      _status = ButtonStatus.awaitingTimeInput;
      _topText = '식사를 같이 하실\n시간을 말씀해 주세요';
      _feedbackText = '';
    });
    await _flutterTts.speak('식사를 같이 하실 시간을 말씀해 주세요');
  }

  Future<void> _delayedInitializeAndStartListening(
      Future<void> Function() startListening) async {
    return Future.delayed(const Duration(seconds: 3), () async {
      await _initializeSpeechAndStartListening(startListening);
    });
  }

  Future<void> _initializeSpeechAndStartListening(
      Future<void> Function() startListening) async {
    await _initializeSpeech();
    if (_isListening) {
      await startListening();
    }
  }

  Future<void> _startListeningFood() async {
    setState(() {
      _status = ButtonStatus.listening;
      _topText = '';
    });
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _food = result.recognizedWords;
        });
      },
    );
    await _endListeningAndVerify(_verifyFood);
  }

  Future<void> _startListeningTime() async {
    setState(() {
      _status = ButtonStatus.listening;
      _topText = '';
    });
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _time = result.recognizedWords;
        });
      },
    );
    await _endListeningAndVerify(_verifyTime);
  }

  Future<void> _endListeningAndVerify(Future<void> Function() verify) async {
    _timer = Timer(const Duration(seconds: 6), () async {
      if (_isListening) {
        await _speech.stop();
        setState(() {
          _isListening = false;
          _topText = '';
        });
        await verify();
      }
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

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(onError: (error) {
      setState(() {
        _isListening = false;
      });
    });

    if (available) {
      setState(() {
        _isListening = true;
      });
    } else {
      setState(() {
        _isListening = false;
      });
    }
  }

  Future<void> _verify(String recognizedText, String confirmationText) async {
    if (recognizedText.isNotEmpty) {
      _status = ButtonStatus.completed;
      await _flutterTts.speak(confirmationText);
      setState(() {
        _feedbackText = confirmationText;
      });
      print(recognizedText);
      return;
    }
      _status = ButtonStatus.idle;
      await _flutterTts.speak('인식된 음성이 없습니다. 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.');
      setState(() {
        _feedbackText = '인식된 음성이 없습니다.';
      });
      print('인식된 음성이 없습니다.');

  }

  Future<void> _verifyFood() async {
    await _verify(_food, '말씀하신 메뉴가 \n$_food 인가요?');
  }

  Future<void> _verifyTime() async {
    await _verify(_time, '말씀하신 시간이 \n$_time 인가요?');
  }

  Future<void> _handleConfirm() async {
    if (_food.isNotEmpty && _time.isEmpty) {
      await _requestTime();
      await _delayedInitializeAndStartListening(_startListeningTime);
    } else if (_food.isNotEmpty && _time.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const FoodRegistrationCompletionAdultScreen()));
    }
  }

  void _handleReject() {
    setState(() {
      _status = ButtonStatus.idle;
      _topText = '식사 등록을 버튼을 누르고 다시 시도해주세요';
      _feedbackText = '';
    });
  }

  Widget _buildAvatarGlow() {
    switch (_status) {
      case ButtonStatus.listening:
        return AvatarGlow(
          animate: true,
          glowColor: Colors.yellow,
          endRadius: 180.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: GestureDetector(
            onTap: speakAndRecognizeFood,
            child: _buildButtonDesign(),
          ),
        );
      case ButtonStatus.awaitingTimeInput:
      case ButtonStatus.completed:
      case ButtonStatus.idle:
      default:
        return AvatarGlow(
          animate: false,
          endRadius: 180.0,
          child: GestureDetector(
            onTap: speakAndRecognizeFood,
            child: _buildButtonDesign(),
          ),
        );
    }
  }

  Widget _buildButtonDesign() {
    switch (_status) {
      case ButtonStatus.awaitingTimeInput:
      case ButtonStatus.listening:
        return Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(80.0),
          ),
          child: const Center(
            child: Icon(
              Icons.mic,
              size: 50,
              color: Colors.white,
            ),
          ),
        );
      case ButtonStatus.completed:
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(150.0, 150.0),
                ),
                child: const Center(
                  child: Text(
                    "네",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 36,
                      color: Colors.white,
                      letterSpacing: 3.0,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _handleReject();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(150.0, 150.0),
                ),
                child: const Center(
                  child: Text(
                    "아니오",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 36,
                      color: Colors.white,
                      letterSpacing: 3.0,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      case ButtonStatus.idle:
      default:
        return Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: const Color(0xffFF7700),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "식사\n등록",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 36,
                color: Colors.white,
                letterSpacing: 3.0,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _flutterTts.stop();
            _timer?.cancel();
            if (_isListening) {
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
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
            if (_feedbackText.isNotEmpty)
              Center(
                  child: Text(_feedbackText,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w900))),
            _buildAvatarGlow(),
            ElevatedShadowButtonAdultWidget(
              width: 190,
              text: "나의 정보",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  MyPageAdultScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
