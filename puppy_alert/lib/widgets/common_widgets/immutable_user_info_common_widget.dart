import 'package:flutter/material.dart';

class ImmutableUserInfoCommonWidget extends StatelessWidget {
  final String _label;
  final String _value;

  const ImmutableUserInfoCommonWidget({
    super.key,
    required String label,
    required String value,
  })  : _value = value,
        _label = label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 55,
      width: 300,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF757575))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            _value,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
