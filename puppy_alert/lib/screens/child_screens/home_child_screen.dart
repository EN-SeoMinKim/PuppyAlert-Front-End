import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/child_screens/food_detail_child_screen.dart';
import 'package:puppy_alert/widgets/child_widgets/search_bar_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';

class HomeChildScreen extends StatefulWidget {
  final String _userAddress;
  final String _userId;

  const HomeChildScreen({super.key, required userAddress, required userId})
      : _userAddress = userAddress,
        _userId = userId;

  @override
  State<StatefulWidget> createState() => _HomeChildScreenState();
}

class _HomeChildScreenState extends State<HomeChildScreen> {
  List<FoodModel> _sortFoodModel(List<FoodModel> foodList) {
    foodList.sort((a, b) {
      if (a.status == 'READY' && b.status != 'READY') {
        return -1;
      } else if (a.status != 'READY' && b.status == 'READY') {
        return 1;
      } else {
        return 0;
      }
    });

    return foodList;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodProvider>(
      create: (context) => FoodProvider(),
      child: Column(
        children: [
          SearchBarChildWidget(
            dongAddress: widget._userAddress,
          ),
          Consumer<FoodProvider>(
            builder: (context, provider, child) {
              List<FoodModel> foodList = _sortFoodModel(provider.getFoodList());
              return Expanded(
                child: ListView.builder(
                  itemCount: foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    FoodCommonWidget foodCommonWidget = FoodCommonWidget(
                      imagePath: foodList[index].imageURL,
                      foodName: foodList[index].menuName,
                      hostName: foodList[index].hostId,
                      time: foodList[index].time,
                      recruitmentStatus: foodList[index].status,
                      userId: widget._userId,
                    );

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailChildScreen(
                                  foodCommonWidget: foodCommonWidget,
                                  canRegister: true,
                                  userId: widget._userId,
                                  foodId: foodList[index].foodId,
                                  allAddress:
                                      '${foodList[index].address} ${foodList[index].addressDetail}',
                                  latitude:
                                      foodList[index].locationMap['latitude'],
                                  longitude:
                                      foodList[index].locationMap['longitude'],
                                  recruitmentStatus: foodList[index].status,
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
      ),
    );
  }
}
