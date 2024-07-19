import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();

  String recognizedText = '';

  Future<void> speakAndRecognize() async {
    await flutterTts.setLanguage('kor');
    await flutterTts.speak('음식을 말해주세요');

    bool available = await speech.initialize(
      onStatus: (status) {
        print('Speech recognition status: $status');
      },
      onError: (error) {
        print('Speech recognition error: $error');
      },
    );

    if (available) {
      await speech.listen(
        onResult: (result) {
          setState(() {
            recognizedText = result.recognizedWords;
          });
        },
      );
    } else {
      print('Speech recognition is not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TTS and Speech Recognition')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: speakAndRecognize,
              child: Text('Start'),
            ),
            SizedBox(height: 20),
            Text('Recognized Text:'),
            SizedBox(height: 10),
            Text(recognizedText, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
