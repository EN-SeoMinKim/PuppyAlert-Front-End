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
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text(_categoryList[index]),
          subtitle: Text(_meatList[index]),
          trailing: Text(_vegetableList[index]),
        );
      }),
    );
  }
}
