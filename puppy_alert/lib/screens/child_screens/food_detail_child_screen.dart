import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import 'package:http/http.dart' as http;

class FoodDetailChildScreen extends StatelessWidget {
  final Widget? _foodCommonWidget;
  final String? _userId;
  final int _foodId;
  final String _allAddress;
  final bool _canRegister;
  final double _latitude, _longitude;

  const FoodDetailChildScreen({
    super.key,
    required canRegister,
    required allAddress,
    required latitude,
    required longitude,
    required int foodId,
    Widget? foodCommonWidget,
    String? userId,
  })  : _foodCommonWidget = foodCommonWidget,
        _allAddress = allAddress,
        _latitude = latitude,
        _longitude = longitude,
        _canRegister = canRegister,
        _userId = userId,
        _foodId = foodId;

  void _applyForFood() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/puppy/food');
    http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'foodId': _foodId,
        'puppyId': _userId,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: const Center(
              child: Text(
                '집밥',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Container(
            height: 20,
            color: Colors.grey[100],
            child: _greyContainer(),
          ),
          Container(
            height: _canRegister ? 0 : 20,
            color: Colors.white,
          ),
          if (_foodCommonWidget != null)
            SizedBox(height: 130, child: _foodCommonWidget),
          if (_canRegister) _registrationColumn(context, _applyForFood),
          Container(
            height: 20,
            color: Colors.grey[100],
            child: _greyContainer(),
          ),
          Container(
            height: _canRegister ? 10 : 30,
            color: Colors.white,
          ),
          Container(
            height: _canRegister ? 368 : 394,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xffFF7700),
                    ),
                    const SizedBox(width: 10),
                    Text(_allAddress),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  height: 230,
                  child: FoodMapChildWidget(
                    markerSet: {
                      NMarker(
                          id: _foodId.toString(),
                          position: NLatLng(_latitude, _longitude))
                    },
                    latitude: _latitude,
                    longitude: _longitude,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 20,
            color: Colors.grey[100],
          ),
        ],
      ),
    );
  }
}

Widget _greyContainer() {
  return Container(
    height: 20,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey[200]!, width: 2.0),
    ),
  );
}

Widget _registrationColumn(BuildContext context, Function() applyFood) {
  return Column(children: [
    Container(
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
    ),
    Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 70,
            child: TextButton(
              onPressed: () {
                applyFood();
                _showConfirmationDialog(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffFFF1E4),
              ),
              child: const Text(
                '신청',
                style: TextStyle(
                  color: Color(0xffFF7700),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          '신청 완료',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xffFF7700),
          ),
        ),
        content: const Text('\n신청이 완료되었습니다.\nhost가 수락할 때까지 잠시만 기다려주세요!',
            style: TextStyle(height: 2.0), textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('확인',
                style: TextStyle(
                  color: Color(0xffFF7700),
                )),
          ),
        ],
      );
    },
  );
}
