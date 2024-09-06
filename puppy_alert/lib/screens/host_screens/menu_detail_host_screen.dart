import 'package:flutter/material.dart';

class MenuDetailHostScreen extends StatelessWidget {
  final List<String> _selectedValueList;

  const MenuDetailHostScreen(
      {super.key, required List<String> selectedValueList})
      : _selectedValueList = selectedValueList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('메뉴 상세 정보', style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
