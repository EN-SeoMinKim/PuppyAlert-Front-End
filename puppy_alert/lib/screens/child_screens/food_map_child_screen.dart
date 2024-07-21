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

  @override
  void initState() {
    super.initState();
    // _markerSet = {NMarker(
    //     id: "sejong",
    //     position: const NLatLng(37.54965636279012, 127.0750237101941))};

    String address = '서울특별시 광진구 능동로 209';
    _markerSet = <NMarker>{};
    _foodMapChildWidget = FoodMapChildWidget(markerSet: _markerSet);
    _foodMapDetailChildWidget =
        FoodMapDetailChildWidget('비빔밥', '김순옥', address, DateTime.now());
    _showWidget = _foodMapChildWidget;

    _getNMarker(address).then((marker) {
      setState(() {
        _markerSet.add(marker);
      });
    });

    _onTappedMarker();
  }

  Future<NMarker> _getNMarker(String address) async {
    http.Response response = await _getResponse(address);
    var jsonData = jsonDecode(response.body);
    JsonEncoder encoder = const JsonEncoder.withIndent(' ');
    String prettyprint = encoder.convert(jsonData);
    print(prettyprint);
    return jsonData;
  }

  Future<http.Response> _getResponse(String address) async {
    Map<String, String> header = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.get('CLIENT_ID'),
      'X-NCP-APIGW-API-KEY': dotenv.get('CLIENT_SECRET')
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
