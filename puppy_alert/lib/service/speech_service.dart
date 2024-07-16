import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  bool get isListening => _isListening;
  String get recognizedText => _text;

  void initSpeech() {
    _speech = stt.SpeechToText();
  }

  Future<void> startListening({
    required Function(String) onResult,
    required Function(String) onError,
    required Function(bool) onStatus,
    required String localeId,
  }) async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        print('onStatus: $val');
        onStatus(val == 'listening');
      },
      onError: (val) {
        print('onError: $val');
        onError(val as String);
      },
    );
    if (available) {
      _isListening = true;
      print('Listening...');
      _speech.listen(
        onResult: (val) {
          _text = val.recognizedWords;
          onResult(val.recognizedWords); // 콘솔에 출력할 수 있도록 콜백 호출
          print('Recognized: ${val.recognizedWords}'); // 콘솔에 인식된 단어 출력 예시
        },
        localeId: localeId,
        listenFor: Duration(seconds: 60),
        pauseFor: Duration(seconds: 3),
        partialResults: true,
        onSoundLevelChange: (level) => print('sound level: $level'),
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    } else {
      _isListening = false;
      _speech.stop();
    }
  }

  void stopListening() {
    if (_isListening) {
      _isListening = false;
      _speech.stop();
    }
  }
}
