import 'package:flutter/material.dart';

class FoodWidget extends StatefulWidget {
  final String imagePath;
  final String foodName;
  final String hostName;
  final String time;
  final String recruitmentStatus;

  const FoodWidget({
    super.key,
    required this.imagePath,
    required this.foodName,
    required this.hostName,
    required this.time,
    required this.recruitmentStatus,
  });

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  bool isFavorite = false;

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.foodName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.hostName),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(widget.time),
              const SizedBox(height: 2),
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
  return FoodWidget(
    imagePath: 'assets/food.png',
    foodName: '비빔밥',
    hostName: '김순옥님',
    time: '18:00',
    recruitmentStatus: '똥강아지 모집완료',
  );
}

