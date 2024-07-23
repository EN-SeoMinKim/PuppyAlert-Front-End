import 'package:flutter/material.dart';

class LongRectangleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final Color backgroundColor;
  final Color textColor;

  LongRectangleButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = 300,
    this.height,
    this.margin = const EdgeInsets.only(top: 30),
    this.fontSize,
    this.backgroundColor = const Color(0xffFF7700),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
