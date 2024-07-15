import 'package:flutter/material.dart';

class OrangeBackgroundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;

  OrangeBackgroundButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.margin,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 30),
      width: width ?? 300,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffFF7700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Color(0xffFF7700)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}