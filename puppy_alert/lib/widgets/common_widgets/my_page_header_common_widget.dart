import 'package:flutter/material.dart';

class MyPageHeaderCommonWidget extends StatelessWidget {
  final String _imagePath;
  final String _userName;

  const MyPageHeaderCommonWidget({
    super.key,
    required String imagePath,
    required String userName,
  })  : _userName = userName,
        _imagePath = imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      color: const Color(0xffFFD6BF),
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          ClipOval(
            child: Image.asset(
              _imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            _userName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
