import 'package:flutter/material.dart';

class FoodWidget extends StatefulWidget {
  final String imagePath;
  final String foodName;
  final String hostName;
  final String time;
  final String recruitmentStatus;
  final Color favorite;

  FoodWidget({
    super.key,
    required this.imagePath,
    required this.foodName,
    required this.hostName,
    required this.time,
    required this.recruitmentStatus,
    required this.favorite,
  });

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              widget.foodName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(widget.hostName),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.favorite_border,
                  color: widget.favorite,
                )
              ],
            ),
            SizedBox(
              height:5,
            ),
            Text(widget.time),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFFFAE1),
                border: Border.all(
                  color: Color(0xff9095A1),
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                widget.recruitmentStatus,
                style: TextStyle(
                  color: Color(0xff7D6600),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

Widget firstFoodWidget() {
  return FoodWidget(
      imagePath: 'food.png',
      foodName: '비빔밥',
      hostName: '김순옥님',
      favorite: Colors.red,
      time: '18:00',
      recruitmentStatus: '똥강아지 모집완료');
}
