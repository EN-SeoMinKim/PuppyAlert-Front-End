import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_detail_child_widget.dart';

class FoodMapChildScreen extends StatefulWidget {
  const FoodMapChildScreen({super.key});

  @override
  State<FoodMapChildScreen> createState() => _FoodMapChildScreenState();
}

class _FoodMapChildScreenState extends State<FoodMapChildScreen> {
  late Widget _showWidget;
  late FoodMapChildWidget _foodMapChildWidget;
  late FoodMapDetailChildWidget _foodMapDetailChildWidget;
  late NMarker _marker;

  @override
  void initState() {
    super.initState();
    _marker = NMarker(
        id: "sejong",
        position: const NLatLng(37.54965636279012, 127.0750237101941));
    _foodMapChildWidget = FoodMapChildWidget(markerSet: {_marker});
    _foodMapDetailChildWidget = FoodMapDetailChildWidget(
        '비빔밥', '김수옥', '서울 광진구 능동로 209', DateTime.now());
    _showWidget = _foodMapChildWidget;
    _initMarkerListener();
  }

  void _initMarkerListener() {
    _marker.setOnTapListener((NMarker marker) {
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

  @override
  Widget build(BuildContext context) {
    return _showWidget;
  }
}
