import 'package:flutter/material.dart';

class WhiteBackgroundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  WhiteBackgroundButton({super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF303030),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


