import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'custom_button_host_widget.dart';

class SpeechRecognitionButtonHostWidget extends StatelessWidget {
  final ButtonStatus _status;
  final VoidCallback _speakAndRecognizeFood;
  final VoidCallback _speakAndRecognizeTime;
  final VoidCallback _clickNoButtonRecognitionFailure;
  final VoidCallback _completeRegisterFood;

  const SpeechRecognitionButtonHostWidget({
    super.key,
    required ButtonStatus status,
    required void Function() speakAndRecognizeFood,
    required void Function() speakAndRecognizeTime,
    required void Function() clickNoButtonRecognitionFailure,
    required void Function() completeRegisterFood,
  })  : _completeRegisterFood = completeRegisterFood,
        _clickNoButtonRecognitionFailure = clickNoButtonRecognitionFailure,
        _speakAndRecognizeTime = speakAndRecognizeTime,
        _speakAndRecognizeFood = speakAndRecognizeFood,
        _status = status;

  @override
  Widget build(BuildContext context) {
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
            onTap: _speakAndRecognizeFood,
            child: _buildButtonDesign(_status, _speakAndRecognizeTime,
                _clickNoButtonRecognitionFailure, _completeRegisterFood),
          ),
        );
      case ButtonStatus.awaitingInput:
      case ButtonStatus.foodInputCompleted:
      case ButtonStatus.timeInputCompleted:
      case ButtonStatus.idle:
      default:
        return AvatarGlow(
          animate: false,
          endRadius: 180.0,
          child: GestureDetector(
            onTap: _speakAndRecognizeFood,
            child: _buildButtonDesign(_status, _speakAndRecognizeTime,
                _clickNoButtonRecognitionFailure, _completeRegisterFood),
          ),
        );
    }
  }
}

Widget _buildButtonDesign(
    ButtonStatus status,
    Function() speakAndRecognizeTime,
    Function() clickNoButtonRecognitionFailure,
    Function() completeRegisterFood) {
  switch (status) {
    case ButtonStatus.awaitingInput:
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
    case ButtonStatus.foodInputCompleted:
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonHostWidget(
                text: "네",
                color: Colors.green,
                onPressed: speakAndRecognizeTime),
            const SizedBox(width: 20),
            CustomButtonHostWidget(
                text: "아니오",
                color: Colors.red,
                onPressed: clickNoButtonRecognitionFailure),
          ],
        ),
      );
    case ButtonStatus.timeInputCompleted:
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonHostWidget(
                text: "네",
                color: Colors.green,
                onPressed: completeRegisterFood),
            const SizedBox(width: 20),
            CustomButtonHostWidget(
                text: "아니오",
                color: Colors.red,
                onPressed: clickNoButtonRecognitionFailure)
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
