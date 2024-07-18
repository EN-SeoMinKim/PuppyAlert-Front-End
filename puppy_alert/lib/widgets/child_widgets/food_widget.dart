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
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width:10),
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
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.foodName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                height: 5,
              ),
              Text(widget.time),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(6,2,6,2),
                decoration: BoxDecoration(
                  color: Color(0xffFFFAE1),
                  borderRadius: BorderRadius.circular(5.0),
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
      ),
    );
  }
}

Widget firstFoodWidget() {
  return FoodWidget(
      imagePath: 'assets/food.png',
      foodName: '비빔밥',
      hostName: '김순옥님',
      favorite: Colors.red,
      time: '18:00',
      recruitmentStatus: '똥강아지 모집완료');
}
