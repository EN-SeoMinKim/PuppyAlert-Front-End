import 'package:flutter/material.dart';

class CustomButtonHostWidget extends StatelessWidget {
  final String _text;
  final Color _color;
  final VoidCallback _onPressed;

  const CustomButtonHostWidget({
    super.key,
    required String text,
    required Color color,
    required void Function() onPressed,
  }) : _onPressed = onPressed, _color = color, _text = text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fixedSize: const Size(150.0, 150.0),
      ),
      child: Center(
        child: Text(
          _text,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 36,
            color: Colors.white,
            letterSpacing: 3.0,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
