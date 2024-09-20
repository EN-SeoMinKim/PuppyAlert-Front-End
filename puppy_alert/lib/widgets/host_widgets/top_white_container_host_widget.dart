import 'package:flutter/material.dart';

class TopWhiteContainerHostWidget extends StatelessWidget {
  final String _text;
  final int _colorNumber1, _colorNumber2;

  const TopWhiteContainerHostWidget(
      {super.key,
      required String text,
      int coloNumber1 = 0xffFFCDCD,
      colorNumber2 = 0xffFFE0BE})
      : _text = text,
        _colorNumber1 = coloNumber1,
        _colorNumber2 = colorNumber2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 24,
            child: CircleAvatar(radius: 10, backgroundColor: Color(_colorNumber1)),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child:
                  CircleAvatar(radius: 7, backgroundColor: Color(_colorNumber2))),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: _text.split('\n')[0]),
                  TextSpan(text: '\n'),
                  TextSpan(text: _text.split('\n')[1]),
                ],
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    );
  }
}
