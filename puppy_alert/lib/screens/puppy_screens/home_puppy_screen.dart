import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/puppy_screens/food_detail_puppy_screen.dart';
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

  void _sortFoodModel(List<FoodModel> foodList) {
    String searchValue = _searchBarChildWidget.searchValue;

    foodList.sort((a, b) {
      if (a.status == 'READY' && b.status != 'READY') {
        return -1;
      } else if (a.status != 'READY' && b.status == 'READY') {
        return 1;
      } else {
        return 0;
      }
    });

    if (searchValue.isNotEmpty) {
      for (int i = 0; i < foodList.length; i++) {
        FoodModel fm = foodList[i];
        if (fm.menuName.contains(searchValue) ||
            fm.hostId.contains(searchValue)) {
          foodList.remove(fm);
          foodList.insert(0, fm);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchBarChildWidget,
        Consumer<FoodProvider>(
          builder: (context, provider, child) {
            List<FoodModel> foodList = provider.getFoodList();
            _sortFoodModel(foodList);
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
                          builder: (context) => FoodDetailPuppyScreen(
                                foodCommonWidget: foodCommonWidget,
                                userId: widget._userId,
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
