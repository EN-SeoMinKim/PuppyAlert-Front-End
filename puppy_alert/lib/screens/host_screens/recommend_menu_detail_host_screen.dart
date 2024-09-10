import 'package:flutter/material.dart';
import 'package:puppy_alert/models/recommend_menu_model.dart';
import 'package:puppy_alert/widgets/host_widgets/recommend_menu_widget.dart';

class RecommendMenuDetailHostScreen extends StatelessWidget {
  final List<String> _categoryList, _meatList, _vegetableList;
  final List<RecommendMenuModel> _recommendMenuList;

  const RecommendMenuDetailHostScreen(
      {super.key,
      required List<String> categoryList,
      required List<String> meatList,
      required List<String> vegetableList,
      required List<RecommendMenuModel> recommendMenuList})
      : _categoryList = categoryList,
        _meatList = meatList,
        _vegetableList = vegetableList,
        _recommendMenuList = recommendMenuList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text('김지원',
                        style: TextStyle(fontSize: 30, color: Colors.white))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)),
                    ]),
                child: Column(
                  children: [
                    Text('카테고리: $_categoryList',
                        style: const TextStyle(fontSize: 20)),
                    Text('고기: $_meatList',
                        style: const TextStyle(fontSize: 20)),
                    Text('채소: $_vegetableList',
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
            for (RecommendMenuModel recommendMenuModel in _recommendMenuList)
              RecommendMenuWidget(recommendMenuModel: recommendMenuModel),
          ],
        ),
      ),
    );
  }
}
