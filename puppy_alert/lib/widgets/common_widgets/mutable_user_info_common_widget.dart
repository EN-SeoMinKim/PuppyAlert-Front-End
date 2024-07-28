import 'package:flutter/material.dart';

class MutableUserInfoCommonWidget extends StatefulWidget {
  final TextEditingController _controller;
  final String _label;

  const MutableUserInfoCommonWidget({
    super.key,
    required TextEditingController controller,
    required String label,
  })  : _label = label,
        _controller = controller;

  @override
  State<MutableUserInfoCommonWidget> createState() =>
      _MutableUserInfoCommonWidgetState();
}

class _MutableUserInfoCommonWidgetState
    extends State<MutableUserInfoCommonWidget> {
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
            widget._label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            height: 15,
            child: TextFormField(
              controller: widget._controller,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 8, right: 8),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
