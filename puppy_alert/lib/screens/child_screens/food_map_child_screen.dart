import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_detail_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import 'food_detail_child_screen.dart';

class FoodMapChildScreen extends StatefulWidget {
  final UserDto _userDto;

  const FoodMapChildScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  State<FoodMapChildScreen> createState() => _FoodMapChildScreenState();
}

class _FoodMapChildScreenState extends State<FoodMapChildScreen> {
  Widget _showWidget = const CircularProgressIndicator();
  late final FoodMapChildWidget _foodMapChildWidget;

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
          _initFoodMapDetailChildWidget(marker, foodList);
        });
      });
    }
  }

  void _initFoodMapDetailChildWidget(NMarker marker, List<FoodModel> foodList) {
    FoodModel? foodModel;

    for (var data in foodList) {
      if (marker.info.id == data.foodId.toString()) {
        foodModel = data;
        break;
      }
    }

    if (foodModel == null) return;

    _showWidget = Column(
      children: [
        SizedBox(height: 460, child: _foodMapChildWidget),
        SizedBox(
            height: 210,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FoodDetailChildScreen(
                      userId: widget._userDto.userId,
                      foodCommonWidget: FoodCommonWidget(
                        userId: widget._userDto.userId,
                        foodModel: foodModel!,
                      ),
                    )));
              },
              child: FoodMapDetailChildWidget(foodModel: foodModel,),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(builder: (context, provider, child) {
      List<FoodModel> foodList = provider.getFoodList();
      Set<NMarker> markerSet = _getMarkerSet(foodList);

      _foodMapChildWidget = FoodMapChildWidget(
          markerSet: markerSet,
          latitude: widget._userDto.location['latitude'] as double,
          longitude: widget._userDto.location['longitude'] as double);
      _showWidget = _foodMapChildWidget;

      _onTappedMarker(markerSet, foodList);
      return Center(child: _showWidget);
    });
  }
}
