import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_dto.dart';
import '../../widgets/common_widgets/food_common_widget.dart';
import 'food_map_child_screen.dart';

class FoodDetailChildScreen extends StatefulWidget {
  const FoodDetailChildScreen({super.key});

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
              style: TextStyle(height: 2.0)),
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
    final UserDto userDto = ModalRoute.of(context)!.settings.arguments as UserDto;

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
            height: 10,
            color: Colors.grey[100],
            child: greyContainer(),
          ),
          const SizedBox(
            height: 130,
            child: FoodCommonWidget(
              imagePath: 'assets/food.png',
              foodName: '비빔밥',
              hostName: '김순옥님',
              time: '18:00',
              recruitmentStatus: '똥강아지 모집완료',
            ),
          ),
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
                      _showConfirmationDialog();
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
          Container(
            height: 10,
            color: Colors.grey[100],
            child: greyContainer(),
          ),
          Container(
            height: 10,
            color: Colors.white,
          ),
          Container(
            height: 300,
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
                  height: 200,
                  child: FoodMapChildScreen(userDto: userDto),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[100],
          ),
        ],
      ),
    );
  }
}

Widget greyContainer() {
  return Container(
    height: 20,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey[200]!, width: 2.0),
    ),
  );
}
