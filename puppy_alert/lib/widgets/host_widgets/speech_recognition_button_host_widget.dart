import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'custom_button_host_widget.dart';

class SpeechRecognitionButtonHostWidget extends StatelessWidget {
  final ButtonStatus _status;
  final VoidCallback _speakAndRecognizeFood,
      _speakAndRecognizeTime,
      _clickNoButtonRecognitionFailure,
      _completeRegisterFood;

  const SpeechRecognitionButtonHostWidget({
    super.key,
    required ButtonStatus status,
    required VoidCallback speakAndRecognizeFood,
    required VoidCallback speakAndRecognizeTime,
    required VoidCallback clickNoButtonRecognitionFailure,
    required VoidCallback completeRegisterFood,
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
          glowColor: Color(0xffFF7700),
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
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          color: const Color(0xffFF7700),
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: const Center(
          child: Icon(
            Icons.mic,
            size: 65,
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
                color: const Color(0xffE6F8E4),
                onPressed: speakAndRecognizeTime),
            const SizedBox(width: 20),
            CustomButtonHostWidget(
                text: "아니오",
                color: const Color(0xffffc2c2),
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
                color: const Color(0xffE6F8E4),
                onPressed: completeRegisterFood),
            const SizedBox(width: 20),
            CustomButtonHostWidget(
                text: "아니오",
                color: const Color(0xffffc2c2),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: const Stack(
          children: [
            Positioned(
              top: 20,
              right: 24,
              child:
                  CircleAvatar(radius: 13, backgroundColor: Color(0xffCDE9FF)),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                child: CircleAvatar(
                    radius: 10, backgroundColor: Color(0xffFFF1CE))),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pending_actions, size: 70),
                  SizedBox(height: 20),
                  Text(
                    "식사 등록",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
