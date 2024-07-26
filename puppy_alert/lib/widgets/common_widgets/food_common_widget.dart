import 'package:flutter/material.dart';

class FoodCommonWidget extends StatefulWidget {
  final String _imagePath, _foodName, _hostName, _time, _recruitmentStatus;

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

  @override
  State<FoodCommonWidget> createState() => _FoodCommonWidgetState();
}

class _FoodCommonWidgetState extends State<FoodCommonWidget> {
  bool _isFavorite = false;
  Color _recruitmentStatusColor = const Color(0xffFFFAE1);

  @override
  void initState() {
    super.initState();

    if (widget._recruitmentStatus == 'READY') {
      _recruitmentStatusColor = const Color(0xED6931);
    }
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._foodName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget._hostName),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(widget._time),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: BoxDecoration(
                  color: _recruitmentStatusColor,
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
