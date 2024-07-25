import 'package:flutter/material.dart';

class WhiteBackgroundButtonCommonWidget extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;

  const WhiteBackgroundButtonCommonWidget({super.key,
    required void Function() onPressed,
    required String text,
  }) : _text = text, _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey[300]!, width: 2),
          ),
        ),
        onPressed: _onPressed,
        child: Text(
          _text,
          style: TextStyle(
            color: Color(0xFF303030),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



