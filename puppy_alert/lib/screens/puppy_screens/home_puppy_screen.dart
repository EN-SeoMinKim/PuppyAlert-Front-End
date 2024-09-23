import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/common_screens/food_detail_common_screen.dart';
import 'package:puppy_alert/widgets/puppy_widgets/search_bar_puppy_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';

class HomePuppyScreen extends StatefulWidget {
  final String _userDongAddress;
  final String _userId;

  const HomePuppyScreen({super.key, required userDongAddress, required userId})
      : _userDongAddress = userDongAddress,
        _userId = userId;

  @override
  State<StatefulWidget> createState() => _HomePuppyScreenState();
}

class _HomePuppyScreenState extends State<HomePuppyScreen> {
  late final SearchBarPuppyWidget _searchBarChildWidget;

  @override
  void initState() {
    super.initState();
    _searchBarChildWidget = SearchBarPuppyWidget(
      dongAddress: widget._userDongAddress,
    );
  }

  List<FoodModel> _getSortFoodModel(List<FoodModel> foodList) {
    List<FoodModel> result = [];
    String? searchValue = _searchBarChildWidget.searchValue;

    if (searchValue.isEmpty || searchValue == null) {
      result = foodList.where((food) => food.status == 'READY').toList();
    } else if (searchValue.isNotEmpty) {
      for (int i = 0; i < foodList.length; i++) {
        if (foodList[i].menuName.contains(searchValue) ||
            foodList[i].hostId.contains(searchValue)) {
          if (foodList[i].status == 'READY') {
            result.add(foodList[i]);
          }
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchBarChildWidget,
        Consumer<FoodProvider>(
          builder: (context, provider, child) {
            List<FoodModel> foodList =
                _getSortFoodModel(provider.getFoodList());

            return Expanded(
              child: ListView.builder(
                itemCount: foodList.length,
                itemBuilder: (BuildContext context, int index) {
                  FoodCommonWidget foodCommonWidget = FoodCommonWidget(
                    foodModel: foodList[index],
                    userId: widget._userId,
                  );
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FoodDetailCommonScreen(
                                foodCommonWidget: foodCommonWidget,
                                userId: widget._userId,
                                isPuppyScreen: true,
                              )));
                    },
                    child: foodCommonWidget,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
