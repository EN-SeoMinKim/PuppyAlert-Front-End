import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/widgets/child_widgets/search_bar_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import '../../models/food_model.dart';

class HomeChildScreen extends StatefulWidget {
  const HomeChildScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeChildScreenState();
}

class _HomeChildScreenState extends State<HomeChildScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodProvider>(
      create: (context) => FoodProvider(),
      child: Column(
        children: [
          const SearchBarChildWidget(),
          Consumer<FoodProvider>(
            builder: (context, provider, child) {
              List<FoodModel> foodList = provider.getFoodList();
              return Expanded(
                child: ListView.builder(
                  itemCount: foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodCommonWidget(
                      imagePath: foodList[index].imageURL,
                      foodName: foodList[index].menu,
                      hostName: foodList[index].hostId,
                      time: foodList[index].time,
                      recruitmentStatus: foodList[index].status,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
