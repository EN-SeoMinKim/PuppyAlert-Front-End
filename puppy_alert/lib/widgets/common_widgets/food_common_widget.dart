import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/child_widgets/favorite_icon_child_widget.dart';

class FoodCommonWidget extends StatelessWidget {
  final String _userId,
      _imagePath,
      _foodName,
      _hostName,
      _time,
      _recruitmentStatus;

  const FoodCommonWidget({
    super.key,
    required String userId,
    required String imagePath,
    required String foodName,
    required String hostName,
    required String time,
    required String recruitmentStatus,
  })  : _userId = userId,
        _recruitmentStatus = recruitmentStatus,
        _time = time,
        _hostName = hostName,
        _foodName = foodName,
        _imagePath = imagePath;

  Color _getBackgroundColor() {
    if (_recruitmentStatus == 'MATCHED') {
      return Colors.grey[200]!;
    }
    return const Color(0xffFFFAE1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                _imagePath,
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
                _foodName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_hostName),
                    FavoriteIconChildWidget(
                        puppyId: _userId, hostId: _hostName),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(_time),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  _recruitmentStatus,
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
