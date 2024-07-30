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
          SearchBarChildWidget(
            address: widget._userAddress,
          ),
          Consumer<FoodProvider>(
            builder: (context, provider, child) {
              List<FoodModel> foodList = provider.getFoodList();

              return Expanded(
                child: ListView.builder(
                  itemCount: foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    FoodCommonWidget foodCommonWidget = FoodCommonWidget(
                      imagePath: foodList[index].imageURL,
                      foodName: foodList[index].menuName,
                      hostName: foodList[index].hostId,
                      time: foodList[index].time,
                      isFavorite: foodList[index].isFavorite,
                      recruitmentStatus: foodList[index].status,
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailChildScreen(
                                  foodCommonWidget: foodCommonWidget,
                                  canRegister: true,
                                  userId: widget._userId,
                                  foodId: foodList[index].foodId,
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
