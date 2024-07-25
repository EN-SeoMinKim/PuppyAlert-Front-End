import 'package:flutter/material.dart';

class ProfileInfoButtonChildWidget extends StatelessWidget {
  final IconData _icon;
  final String _text;
  final VoidCallback _onPressed;

  const ProfileInfoButtonChildWidget({
    super.key,
    required IconData icon,
    required String text,
    required void Function() onPressed,
  }) : _onPressed = onPressed, _text = text, _icon = icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        side: BorderSide.none,
        elevation: 0,
        fixedSize: const Size.fromHeight(50.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _icon,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Text(
                _text,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.grey[700],
          )
        ],
      ),
    );
  }
}