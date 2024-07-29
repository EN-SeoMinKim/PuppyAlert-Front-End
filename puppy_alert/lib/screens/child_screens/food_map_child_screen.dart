import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/models/user_dto.dart';
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
  late Widget _showWidget;
  late final FoodMapChildWidget _foodMapChildWidget;
  late final _foodJsonData;

  @override
  void initState() {
    super.initState();
    _showWidget = const CircularProgressIndicator();

    _initFoodMapChildWidget().then((markerSet) {
      _foodMapChildWidget = FoodMapChildWidget(
          markerSet: markerSet,
          latitude: widget._userDto.location['latitude'] as double,
          longitude: widget._userDto.location['longitude'] as double);
      _showWidget = _foodMapChildWidget;

      setState(() {
        _onTappedMarker(markerSet);
      });
    });
  }

  Future<Set<NMarker>> _initFoodMapChildWidget() async {
    Set<NMarker> markerSet = {};
    http.Response response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/puppy/food?puppyId=${widget._userDto.userId}'));
    _foodJsonData = jsonDecode(utf8.decode(response.bodyBytes));

    for (var data in _foodJsonData) {
      markerSet.add(NMarker(
          id: '${data['foodId']}',
          position: NLatLng(
              data['location']['latitude'], data['location']['longitude'])));
    }

    return markerSet;
  }

  void _initFoodMapDetailChildWidget(NMarker marker) {
    var foodInfo;
    int markerId = int.parse(marker.info.id);

    for (var data in _foodJsonData) {
      int dataId = int.parse(data['foodId'].toString());
      if (markerId == dataId) {
        foodInfo = data;
        break;
      }
    }

    _showWidget = Column(
      children: [
        SizedBox(height: 400, child: _foodMapChildWidget),
        SizedBox(
            height: 250,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FoodDetailChildScreen(
                        foodId: foodInfo['foodId'],
                        foodCommonWidget: FoodCommonWidget(
                          userId: widget._userDto.userId,
                          imagePath: foodInfo['imageURL'],
                          foodName: foodInfo['menuName'],
                          recruitmentStatus: foodInfo['status'],
                          hostName: foodInfo['hostId'],
                          time: foodInfo['time'],
                          isFavorite: foodInfo['isFavorite'],
                        ),
                        canRegister: true,
                        userId: widget._userDto.userId)));
              },
              child: FoodMapDetailChildWidget(foodInfo['menuName'],
                  foodInfo['hostId'], foodInfo['address'], foodInfo['time']),
            )),
      ],
    );
  }

  void _onTappedMarker(Set<NMarker> markerSet) {
    if (markerSet.isNotEmpty) {
      for (var m in markerSet) {
        m.setOnTapListener((NMarker marker) {
          setState(() {
            _initFoodMapDetailChildWidget(marker);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _showWidget);
  }
}
