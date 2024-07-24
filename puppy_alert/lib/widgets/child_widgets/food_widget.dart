import 'package:flutter/material.dart';


class HostWidget extends StatefulWidget {
  final String imagePath;
  final String hostName;
  final String recentMealDate;
  final Color favorite;

  const HostWidget({
    super.key,
    required this.imagePath,
    required this.hostName,
    required this.recentMealDate,
    required this.favorite,
  });

  @override
  State<HostWidget> createState() => _HostWidgetState();
}

class _HostWidgetState extends State<HostWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          ClipOval(
            child: Image.asset(
              widget.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 40),
          Column(
            children: [
              Text(
                widget.hostName,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  widget.recentMealDate,
              style: TextStyle(fontWeight: FontWeight.w200, color: Colors.grey[500]),),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.favorite_border,
            color: widget.favorite,
          ),
          SizedBox(width: 30),
        ],
      )
    ]);
  }
}

Widget firstHostWidget() {
  return HostWidget(
    imagePath: 'image.png',
    hostName: '김순옥님',
    recentMealDate: '7일 전에 식사',
    favorite: Colors.red,
  );
}
