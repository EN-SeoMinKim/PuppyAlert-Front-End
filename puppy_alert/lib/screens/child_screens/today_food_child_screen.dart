import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';

import '../../widgets/child_widgets/food_map_child_widget.dart';

class TodayFoodChildScreen extends StatefulWidget {
  const TodayFoodChildScreen({super.key});

  @override
  State<TodayFoodChildScreen> createState() => _TodayFoodChildScreenState();
}

class _TodayFoodChildScreenState extends State<TodayFoodChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(
            flex: 10,
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  '오늘의 집밥',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: greyContainer(),
          ),
          const Flexible(
              flex: 14,
              child: FoodCommonWidget(
                imagePath: 'assets/food.png',
                foodName: '비빔밥',
                hostName: '김순옥님',
                time: '18:00',
                recruitmentStatus: '똥강아지 모집완료',
              )),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 70,
                        child: TextButton(
                          onPressed: () {},
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
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: greyContainer(),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.white,
            ),
          ),
          Flexible(
            flex: 30,
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xffFF7700),
                        ),
                        SizedBox(width: 10),
                        Text('주소 입력할 부분!!')
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 220,
                      child: FoodMapChildWidget(),
                    ),
                  ],
                )),
          ),
          Flexible(
            flex: 1,
            child: greyContainer(),
          ),
        ],
      ),
    );
  }
}

Widget greyContainer() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey[200]!, width: 2.0),
    ),
  );
}
