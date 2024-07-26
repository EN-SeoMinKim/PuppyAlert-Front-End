import 'package:flutter/material.dart';

class FoodCommonWidget extends StatefulWidget {
  final String _imagePath;
  final String _foodName;
  final String _hostName;
  final String _time;
  final String _recruitmentStatus;

  const FoodCommonWidget({
    super.key,
    required String imagePath,
    required String foodName,
    required String hostName,
    required String time,
    required String recruitmentStatus,
  })  : _imagePath = imagePath,
        _foodName = foodName,
        _hostName = hostName,
        _time = time,
        _recruitmentStatus = recruitmentStatus;

  String get imagePath => _imagePath;
  String get foodName => _foodName;
  String get hostName => _hostName;
  String get time => _time;
  String get recruitmentStatus => _recruitmentStatus;

  @override
  State<FoodCommonWidget> createState() => _FoodCommonWidgetState();
}

class _FoodCommonWidgetState extends State<FoodCommonWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                widget.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.foodName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.hostName),
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Text(widget.time),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFAE1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  widget.recruitmentStatus,
                  style: const TextStyle(
                    color: Color(0xff7D6600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget firstFoodWidget() {
  return const FoodCommonWidget(
    imagePath: 'assets/food.png',
    foodName: '비빔밥',
    hostName: '김순옥님',
    time: '18:00',
    recruitmentStatus: '똥강아지 모집완료',
  );
}
