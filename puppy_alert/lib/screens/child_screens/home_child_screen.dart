import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/food_detail_child_screen.dart';
import 'package:puppy_alert/widgets/child_widgets/search_bar_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';

class HomeChildScreen extends StatefulWidget {
  const HomeChildScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeChildScreenState();
}

class _HomeChildScreenState extends State<HomeChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SearchBarChildWidget(),
        FoodCommonWidget(
          imagePath: 'assets/food.png',
          foodName: '비빔밥',
          hostName: '김순옥님',
          time: '18:00',
          recruitmentStatus: 'MATCHED',
          isFavorite: true,
          foodDetailChildScreen: () => const FoodDetailChildScreen(canRegister: true,),
        ),
      ],
    );
  }
}
