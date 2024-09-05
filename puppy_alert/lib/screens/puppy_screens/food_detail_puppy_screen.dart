import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/widgets/puppy_widgets/food_map_puppy_widget.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';

class FoodDetailPuppyScreen extends StatelessWidget {
  final FoodCommonWidget _foodCommonWidget;
  final String _userId;
  final FoodModel _foodModel;
  final bool _canRegister;

  FoodDetailPuppyScreen({
    super.key,
    required String userId,
    required FoodCommonWidget foodCommonWidget,
  })  : _userId = userId,
        _foodCommonWidget = foodCommonWidget,
        _foodModel = foodCommonWidget.foodModel,
        _canRegister = foodCommonWidget.foodModel.status == 'READY';

  void _applyForFood() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/puppy/food');

    http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'foodId': _foodModel.foodId,
        'puppyId': _userId,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 130, child: _foodCommonWidget),
            if (_canRegister)
              _registrationColumn(context, _applyForFood, _foodModel.status),
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
                      Text('${_foodModel.address} ${_foodModel.addressDetail}'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 300,
                    height: 230,
                    child: FoodMapPuppyWidget(
                      markerSet: {
                        NMarker(
                            id: _foodModel.foodId.toString(),
                            position: NLatLng(
                              _foodModel.locationMap['latitude'],
                              _foodModel.locationMap['longitude'],
                            )),
                      },
                      foodSet: {_foodModel},
                      userLatLng: NLatLng(
                        _foodModel.locationMap['latitude'],
                        _foodModel.locationMap['longitude'],
                      ),
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

Widget _registrationColumn(
    BuildContext context, Function() applyFood, String recruitmentStatus) {
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
            width: recruitmentStatus == 'READY' ? 70 : 90,
            child: TextButton(
              onPressed: () {
                applyFood();
                _showConfirmationDialog(context);
                recruitmentStatus == 'READY'
                    ? {applyFood(), _showConfirmationDialog(context)}
                    : null;
              },
              style: TextButton.styleFrom(
                backgroundColor: recruitmentStatus == 'READY'
                    ? const Color(0xffFFF1E4)
                    : Colors.grey[200]!,
              ),
              child: Text(
                recruitmentStatus == 'READY' ? '신청' : '신청완료',
                style: TextStyle(
                  color: recruitmentStatus == 'READY'
                      ? const Color(0xffFF7700)
                      : const Color(0xff7D6600),
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
        content: const Text('\n신청이 완료되었습니다!',
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
