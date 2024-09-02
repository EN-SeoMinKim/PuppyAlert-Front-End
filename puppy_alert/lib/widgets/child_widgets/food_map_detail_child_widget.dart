import 'package:flutter/material.dart';
import 'package:puppy_alert/models/food_model.dart';

class FoodMapDetailChildWidget extends StatelessWidget {
  final FoodModel _foodModel;

  const FoodMapDetailChildWidget({super.key, required FoodModel foodModel})
      : _foodModel = foodModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                child: Text(
                  "     ${_foodModel.menuName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(_foodModel.hostNickName),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 30)
                ],
              ),
            ],
          ),
        ),
        _infoWidget(Icons.access_time, 'Time', _foodModel.time),
        _infoWidget(Icons.location_on_outlined, 'Address', _foodModel.address),
      ],
    );
  }
}

Widget _infoWidget(IconData iconData, String topString, String bottomString) {
  return Column(
    children: [
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Icon(
            iconData,
            color: const Color(0xffFF7700),
            size: 25,
          ),
          const SizedBox(width: 5),
          Text(
            topString,
            style: const TextStyle(color: Color(0xffFF7700), fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        child: SizedBox(
            width: double.maxFinite,
            child: Text(
              bottomString,
              style: const TextStyle(fontSize: 20),
            )),
      ),
    ],
  );
}
