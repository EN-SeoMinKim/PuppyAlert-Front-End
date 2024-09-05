import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/widgets/puppy_widgets/food_map_puppy_widget.dart';
import 'package:puppy_alert/widgets/puppy_widgets/food_map_detail_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import 'food_detail_puppy_screen.dart';

class FoodMapPuppyScreen extends StatefulWidget {
  final UserModel _userModel;

  const FoodMapPuppyScreen({super.key, required userModel})
      : _userModel = userModel;

  @override
  State<FoodMapPuppyScreen> createState() => _FoodMapPuppyScreenState();
}

class _FoodMapPuppyScreenState extends State<FoodMapPuppyScreen> {
  Widget _showWidget = const CircularProgressIndicator();
  FoodMapPuppyWidget? _foodMapChildWidget;

  void _initFoodMapChildWidget(List<FoodModel> foodList) {
    Set<NMarker> markerSet = _getMarkerSet(foodList);

    _foodMapChildWidget = FoodMapPuppyWidget(
      markerSet: markerSet,
      foodSet: foodList.toSet(),
      userLatLng: widget._userModel.userLatLng,
    );
    _showWidget = _foodMapChildWidget!;

    _onTappedMarker(markerSet, foodList);
  }

  Set<NMarker> _getMarkerSet(List<FoodModel> foodList) {
    Set<NMarker> markerSet = {};

    for (var data in foodList) {
      NMarker marker = NMarker(
          id: data.foodId.toString(),
          position: NLatLng(
              data.locationMap['latitude'], data.locationMap['longitude']));
      markerSet.add(marker);
    }
    return markerSet;
  }

  void _onTappedMarker(Set<NMarker> markerSet, List<FoodModel> foodList) {
    if (markerSet.isEmpty) return;

    for (var m in markerSet) {
      m.setOnTapListener((NMarker marker) {
        setState(() {
          _showFoodMapDetailChildWidget(marker, foodList);
        });
      });
    }
  }

  void _showFoodMapDetailChildWidget(NMarker marker, List<FoodModel> foodList) {
    FoodModel? foodModel;

    for (var data in foodList) {
      if (marker.info.id == data.foodId.toString()) {
        foodModel = data;
        break;
      }
    }

    if (foodModel == null) return;

    _showWidget = SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            child: _foodMapChildWidget!,
          ),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 250,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FoodDetailPuppyScreen(
                          userId: widget._userModel.userId,
                          foodCommonWidget: FoodCommonWidget(
                            userId: widget._userModel.userId,
                            foodModel: foodModel!,
                          ),
                        )));
              },
              child: FoodMapDetailChildWidget(
                foodModel: foodModel,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(builder: (context, provider, child) {
      if (_foodMapChildWidget == null) {
        _initFoodMapChildWidget(provider.getFoodList());
      }

      return Center(child: _showWidget);
    });
  }
}
