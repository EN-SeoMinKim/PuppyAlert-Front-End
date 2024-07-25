import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_detail_child_widget.dart';

class FoodMapChildScreen extends StatefulWidget {
  const FoodMapChildScreen({super.key});

  @override
  State<FoodMapChildScreen> createState() => _FoodMapChildScreenState();
}

class _FoodMapChildScreenState extends State<FoodMapChildScreen> {
  late Widget _showWidget;
  late final FoodMapChildWidget _foodMapChildWidget;
  late final FoodMapDetailChildWidget _foodMapDetailChildWidget;
  late Set<NMarker> _markerSet;
  late int _markerIndex;

  @override
  void initState() {
    super.initState();
    _markerIndex = -1;
    String address = '서울특별시 군자로 10길 29-5';
    _markerSet = <NMarker>{};
    _foodMapChildWidget = FoodMapChildWidget();
    _foodMapDetailChildWidget =
        FoodMapDetailChildWidget('비빔밥', '김순옥', address, DateTime.now());
    _showWidget = _foodMapChildWidget;

    _getNMarker(address).then((marker) {
      setState(() {
        _markerSet.add(marker);
        _foodMapChildWidget.setMarkerSet(_markerSet);
        _onTappedMarker();
      });
    });
  }

  Future<NMarker> _getNMarker(String address) async {
    http.Response response = await _getResponse(address);
    var jsonData = jsonDecode(response.body);
    String longitude = jsonData['addresses'][0]['y'];
    String latitude = jsonData['addresses'][0]['x'];

    _markerIndex++;
    return NMarker(
        id: '$_markerIndex',
        position: NLatLng(
            double.parse(longitude), double.parse(latitude)));
  }

  Future<http.Response> _getResponse(String address) async {
    Map<String, String> header = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.get('NAVER_API_ID'),
      'X-NCP-APIGW-API-KEY': dotenv.get('NAVER_API_SECRET')
    };

    return await http.get(
        Uri.parse(
            'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=$address'),
        headers: header);
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
    return _showWidget;
  }
}
