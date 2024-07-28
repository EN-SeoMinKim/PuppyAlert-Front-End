import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';
import '../../widgets/common_widgets/food_common_widget.dart';

class FoodDetailChildScreen extends StatefulWidget {
  final bool _canRegister;

  const FoodDetailChildScreen({super.key, required bool canRegister})
      : _canRegister = canRegister;

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
          SizedBox(
              height: 130,
              child: FoodCommonWidget(
                  imagePath:
                      "https://thenaum.cdn-nhncommerce.com/data/goods/20/07/31/1000005027/1000005027_detail_093.jpg",
                  foodName: '비빔밥',
                  hostName: '김순옥님',
                  time: '18:00',
                  recruitmentStatus: 'READY',
                  isFavorite: true)),
          if (widget._canRegister) _registrationColumn(_showConfirmationDialog),
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

Widget _registrationColumn(Function() showConfirmationDialog) {
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
                showConfirmationDialog();
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
