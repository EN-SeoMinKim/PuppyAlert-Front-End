import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import 'package:http/http.dart' as http;

class FoodDetailChildScreen extends StatefulWidget {
  final Widget _foodCommonWidget;
  final int _foodId;
  final bool _canRegister;
  final String _recruitmentStatus;
  final String? _userId;

  const FoodDetailChildScreen(
      {super.key,
      required Widget foodCommonWidget,
      required bool canRegister,
      required String recruitmentStatus,
      String? userId,
      required int foodId})
      : _foodCommonWidget = foodCommonWidget,
        _canRegister = canRegister,
        _recruitmentStatus = recruitmentStatus,
        _userId = userId,
        _foodId = foodId;

  @override
  State<FoodDetailChildScreen> createState() => _FoodDetailChildScreenState();
}

class _FoodDetailChildScreenState extends State<FoodDetailChildScreen> {
  void _showConfirmationDialog() {
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

  void _applyForFood() async {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/puppy/food');

    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'foodId': widget._foodId,
        'puppyId': widget._userId,
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
            height: widget._canRegister ? 0 : 20,
            color: Colors.white,
          ),
          SizedBox(height: 130, child: widget._foodCommonWidget),
          if (widget._canRegister)
            _registrationColumn(
              _showConfirmationDialog,
              _applyForFood,
              widget._recruitmentStatus
            ),
          Container(
            height: 20,
            color: Colors.grey[100],
            child: _greyContainer(),
          ),
          Container(
            height: widget._canRegister ? 10 : 30,
            color: Colors.white,
          ),
          Container(
            height: widget._canRegister ? 368 : 394,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Row(
                  children: [
                    SizedBox(width: 40),
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xffFF7700),
                    ),
                    SizedBox(width: 10),
                    Text('주소 입력할 부분!!')
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  height: 230,
                  child: FoodMapChildWidget(
                    markerSet: {
                      NMarker(
                          id: 'test',
                          position: const NLatLng(37.5666102, 126.9783881))
                    },
                    latitude: 37.5666102,
                    longitude: 126.9783881,
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

Widget _registrationColumn(
    Function() showConfirmationDialog, Function() applyFood, String recruitmentStatus) {
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
            width: recruitmentStatus == 'READY' ? 70: 90,
            child: TextButton(
              onPressed: () {
                recruitmentStatus == 'READY' ? {applyFood(), showConfirmationDialog()} :null;
              },
              style: TextButton.styleFrom(
                backgroundColor: recruitmentStatus == 'READY' ? const Color(0xffFFF1E4) : Colors.grey[200]!,
              ),
              child:  Text(
                recruitmentStatus == 'READY' ? '신청' :'신청완료',
                style: TextStyle(
                  color: recruitmentStatus == 'READY' ?const Color(0xffFF7700):const Color(0xff7D6600) ,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
}
