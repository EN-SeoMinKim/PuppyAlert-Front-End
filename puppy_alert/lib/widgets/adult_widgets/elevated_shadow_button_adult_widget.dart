import 'package:flutter/material.dart';

class ElevatedShadowButtonAdultWidget extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;
  final Color _backgroundColor;
  final Color _textColor;
  final double _height;
  final double _width;

  const ElevatedShadowButtonAdultWidget({
    super.key,
    required void Function() onPressed,
    required String text,
    Color backgroundColor = const Color(0xffEEEEEE),
    Color textColor = Colors.black,
    double height = 100.0,
    double width = 170.0,
  }) : _width = width, _height = height, _textColor = textColor, _text = text, _onPressed = onPressed, _backgroundColor = backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: _width,
      height: _height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: _onPressed,
        child: Text(
          _text,
          style: TextStyle(
            color: _textColor,
            fontWeight: FontWeight.w900,
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
