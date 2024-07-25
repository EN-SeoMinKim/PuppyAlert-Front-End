import 'package:flutter/material.dart';

class LongRectangleButtonCommonWidget extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;
  final double _width;
  final double? _height;
  final EdgeInsetsGeometry? _margin;
  final double? _fontSize;
  final Color _backgroundColor;
  final Color _textColor;

  const LongRectangleButtonCommonWidget({
    super.key,
    required void Function() onPressed,
    required String text,
    double width = 300,
    double? height,
    EdgeInsetsGeometry? margin = const EdgeInsets.only(top: 30),
    double? fontSize,
    Color backgroundColor = const Color(0xffFF7700),
    Color textColor = Colors.white,
  }) : _textColor = textColor, _backgroundColor = backgroundColor, _fontSize = fontSize, _margin = margin, _height = height, _width = width, _text = text, _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      width: _width ,
      height: _height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: _onPressed,
        child: Text(
          _text,
          style: TextStyle(
            color: _textColor,
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
          ),
        ),
      ),
    );
  }
}
