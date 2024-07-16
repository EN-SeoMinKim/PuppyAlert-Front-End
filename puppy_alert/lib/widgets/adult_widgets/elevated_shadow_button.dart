import 'package:flutter/material.dart';

class ElevatedShadowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double height;

  ElevatedShadowButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = const Color(0xffEEEEEE),
    this.textColor = Colors.black,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: 170,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
