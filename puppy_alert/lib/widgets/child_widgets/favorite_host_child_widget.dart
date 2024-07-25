import 'package:flutter/material.dart';


class FavoriteHostChildWidget extends StatefulWidget {
  final String _imagePath;
  final String _hostName;
  final String _recentMealDate;
  final Color _favorite;

  const FavoriteHostChildWidget({
    super.key,
    required String imagePath,
    required String hostName,
    required String recentMealDate,
    required Color favorite,
  }) : _favorite = favorite, _recentMealDate = recentMealDate, _hostName = hostName, _imagePath = imagePath;

  @override
  State<FavoriteHostChildWidget> createState() => _FavoriteHostChildWidgetState();
}

class _FavoriteHostChildWidgetState extends State<FavoriteHostChildWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          ClipOval(
            child: Image.asset(
              widget._imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 40),
          Column(
            children: [
              Text(
                widget._hostName,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  widget._recentMealDate,
              style: TextStyle(fontWeight: FontWeight.w200, color: Colors.grey[500]),),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.favorite_border,
            color: widget._favorite,
          ),
          SizedBox(width: 30),
        ],
      )
    ]);
  }
}

Widget firstHostWidget() {
  return FavoriteHostChildWidget(
    imagePath: 'image.png',
    hostName: '김순옥님',
    recentMealDate: '7일 전에 식사',
    favorite: Colors.red,
  );
}
