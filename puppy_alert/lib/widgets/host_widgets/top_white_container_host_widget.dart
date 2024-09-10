import 'package:flutter/material.dart';

class TopWhiteContainerHostWidget extends StatelessWidget {
  final String _text;

  const TopWhiteContainerHostWidget({super.key, required String text})
      : _text = text;

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
          const Positioned(
            top: 20,
            left: 24,
            child: CircleAvatar(radius: 10, backgroundColor: Color(0xffFFCDCD)),
          ),
          const Positioned(
              bottom: 20,
              right: 20,
              child:
                  CircleAvatar(radius: 7, backgroundColor: Color(0xffFFE0BE))),
          Center(
            child: Text(
              _text,
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
