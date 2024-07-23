import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/child_widgets/home_food_child_widget.dart';
import 'package:puppy_alert/widgets/child_widgets/search_bar_child_widget.dart';

class HomeChildScreen extends StatefulWidget {
  const HomeChildScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeChildScreenState();
}

class _HomeChildScreenState extends State<HomeChildScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchBarChildWidget(),
        HomeFoodChildWidget(),
        HomeFoodChildWidget(),
        HomeFoodChildWidget(),
        HomeFoodChildWidget()
      ],
    );
  }
}
