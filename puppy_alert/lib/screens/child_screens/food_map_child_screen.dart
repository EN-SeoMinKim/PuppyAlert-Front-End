import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_detail_child_widget.dart';

class FoodMapChildScreen extends StatefulWidget {
  final UserDto _userDto;

  const FoodMapChildScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  State<FoodMapChildScreen> createState() => _FoodMapChildScreenState();
}

class _FoodMapChildScreenState extends State<FoodMapChildScreen> {
  late Set<NMarker> _markerSet;
  late Widget _showWidget;
  late final FoodMapChildWidget _foodMapChildWidget;
  late final FoodMapDetailChildWidget _foodMapDetailChildWidget;

  @override
  void initState() {
    super.initState();
    // 음식 데이터 받아와서 제대로 띄우기
    _foodMapDetailChildWidget = FoodMapDetailChildWidget(
        '비빔밥', '김순옥', widget._userDto.address, DateTime.now());
    _showWidget = _foodMapChildWidget;

    _initNMarkerSet().then((_) {
      _foodMapChildWidget = FoodMapChildWidget(
          markerSet: _markerSet,
          latitude: widget._userDto.location['latitude'] as double,
          longitude: widget._userDto.location['longitude'] as double);
      setState(() {
        _onTappedMarker();
      });
    });
  }

  Future<void> _initNMarkerSet() async {
    _markerSet = {};
    String value = (await http.get(Uri.parse(
            '${dotenv.get('BASE_URL')}/puppy/food?puppyId=${widget._userDto.name}')))
        .body;
    var jsonData = jsonDecode(value);

    for (var data in jsonData) {
      _markerSet.add(NMarker(
          id: '${data['foodId']}',
          position: NLatLng(data['latitude'], data['longitude'])));
    }
  }

  void _onTappedMarker() {
    if (_markerSet.isNotEmpty) {
      for (var m in _markerSet) {
        m.setOnTapListener((NMarker marker) {
          setState(() {
            _showWidget = Column(
              children: [
                SizedBox(height: 400, child: _foodMapChildWidget),
                SizedBox(height: 250, child: _foodMapDetailChildWidget),
              ],
            );
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _showWidget ?? CircularProgressIndicator(),
    );
  }
}
