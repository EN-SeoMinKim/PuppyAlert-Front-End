import 'package:flutter/material.dart';
import 'package:puppy_alert/models/recommend_menu_model.dart';
import 'package:puppy_alert/widgets/host_widgets/recommend_menu_widget.dart';
import 'package:puppy_alert/widgets/host_widgets/top_white_container_host_widget.dart';

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
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: TopWhiteContainerHostWidget(text: "밑의 메뉴들은\n어떠신가요?"),
              ),
              SizedBox(height: 30),
              for (RecommendMenuModel recommendMenuModel in _recommendMenuList)
                RecommendMenuWidget(recommendMenuModel: recommendMenuModel),
            ],
          ),
        ),
      ),
    );
  }
}
