import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';

class SpeechScreenTest extends StatefulWidget {
  const SpeechScreenTest({super.key});

  @override
  State<SpeechScreenTest> createState() => _SpeechScreenTestState();
}

class _SpeechScreenTestState extends State<SpeechScreenTest> {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();

  String recognizedText = '';
  String menu = '';
  String time ='';
  String feedbackText = '';
  String initialPromptText = '등록하실 메뉴를 말씀해 주세요';
  bool _isListening = false;
  Timer? _timer;

  Future<void> speakAndRecognize() async {
    setState(() {
      recognizedText = '';
      feedbackText = '';
      initialPromptText = '등록하실 메뉴를 말씀해 주세요';
    });

    await flutterTts.setLanguage('ko');
    await flutterTts.speak('등록하실 메뉴를 말씀해 주세요');

    await _initializeSpeech();
    if (_isListening) {
      await _startListeningMenu();

      Timer(Duration(seconds: 16), () async {
        initialPromptText = '식사를 같이 하실 시간을 말씀해 주세요';
        feedbackText = '';
        await flutterTts.setLanguage('ko');
        await flutterTts.speak('식사를 같이 하실 시간을 말씀해 주세요');
        await _initializeSpeech();
        await _startListeningTime();
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

    // 6초 후 음성 인식을 자동으로 종료
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



  //=============================================

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
      await speakText('말씀하신 시간이 $recognizedText 인가요? 아니면 식사등록 버튼을 누르고 처음부터 다시 말씀해 주세요.',);
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
      appBar: AppBar(title: Text('TTS and Speech Recognition')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (initialPromptText.isNotEmpty)
              Text(
                initialPromptText,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            Text(feedbackText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: speakAndRecognize,
              child: Text('Start'),
            ),
            SizedBox(height: 20),
            Text('Recognized Text:'),
            SizedBox(height: 10),
            Text(recognizedText, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(feedbackText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

