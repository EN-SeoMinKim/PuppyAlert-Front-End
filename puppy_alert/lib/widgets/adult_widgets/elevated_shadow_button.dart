import 'package:flutter/material.dart';

class ElevatedShadowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color _backgroundColor;
  final Color textColor;
  final double height;
  final double width;

  const ElevatedShadowButton({
    super.key,
    required this.onPressed,
    required this.text,
    Color backgroundColor = const Color(0xffEEEEEE),
    this.textColor = Colors.black,
    this.height = 100.0,
    this.width = 170.0,
  }) : _backgroundColor = backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
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
