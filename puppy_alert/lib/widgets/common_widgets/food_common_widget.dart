import 'package:flutter/material.dart';

class FoodCommonWidget extends StatefulWidget {
  final String _imagePath, _foodName, _hostName, _time, _recruitmentStatus;
  late bool _isFavorite;

  FoodCommonWidget({
    super.key,
    required String imagePath,
    required String foodName,
    required String hostName,
    required String time,
    required String recruitmentStatus,
    required bool isFavorite,
  })  : _isFavorite = isFavorite,
        _recruitmentStatus = recruitmentStatus,
        _time = time,
        _hostName = hostName,
        _foodName = foodName,
        _imagePath = imagePath;

  @override
  State<FoodCommonWidget> createState() => _FoodCommonWidgetState();
}

class _FoodCommonWidgetState extends State<FoodCommonWidget> {
  Color _getBackgroundColor(String recruitmentStatus) {
    if (recruitmentStatus == 'MATCHED') {
      return Colors.grey[200]!;
    }
    return const Color(0xffFFFAE1);
  }

  Icon _getFavoriteIcon(bool isFavorite) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : Colors.grey,
      size: 20,
    );
  }

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
                child: Image.network(
                  widget._imagePath,
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
                  widget._foodName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget._hostName),
                      IconButton(
                        icon: _getFavoriteIcon(widget._isFavorite),
                        onPressed: () {
                          setState(() {
                            widget._isFavorite = !widget._isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(widget._time),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(widget._recruitmentStatus),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget._recruitmentStatus,
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
