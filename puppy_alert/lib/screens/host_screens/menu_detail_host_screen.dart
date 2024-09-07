import 'package:flutter/material.dart';

class MenuDetailHostScreen extends StatelessWidget {
  final List<String> _categoryList, _meatList, _vegetableList;

  const MenuDetailHostScreen(
      {super.key,
      required List<String> categoryList,
      required List<String> meatList,
      required List<String> vegetableList})
      : _categoryList = categoryList,
        _meatList = meatList,
        _vegetableList = vegetableList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('메뉴 상세 정보 입력'),
            const SizedBox(height: 20),
            const Text('카테고리'),
            if (_categoryList.isNotEmpty)
              for (String category in _categoryList) Text(category),
            const SizedBox(height: 20),
            const Text('고기'),
            if (_meatList.isNotEmpty)
              for (String meat in _meatList) Text(meat),
            const SizedBox(height: 20),
            const Text('채소'),
            if (_vegetableList.isNotEmpty)
              for (String vegetable in _vegetableList) Text(vegetable),
          ],
        ),
      ),
    );
  }
}
