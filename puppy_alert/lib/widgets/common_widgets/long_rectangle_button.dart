import 'package:flutter/material.dart';

class LongRectangleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  LongRectangleButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.margin,
    this.fontSize,
    this.backgroundColor = const Color(0xffFF7700), // 기본 배경색 오렌지
    this.textColor = Colors.white, // 기본 텍스트 색상 흰색
    this.borderColor = const Color(0xffFF7700), // 기본 테두리 색상 오렌지
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 30),
      width: width ?? 300,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: borderColor),
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
