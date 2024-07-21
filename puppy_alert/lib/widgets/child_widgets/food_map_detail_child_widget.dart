import 'package:flutter/material.dart';

class FoodMapDetailChildWidget extends StatelessWidget {
  final String _foodName, _personName, _address;
  final DateTime _dateTime;

  const FoodMapDetailChildWidget(
      this._foodName, this._personName, this._address, this._dateTime,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 100.0, 0),
                child: Text(
                  _foodName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Material.defaultSplashRadius,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 0, 0, 0),
                child: Row(
                  children: [
                    Text(_personName),
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _infoWidget(Icons.access_time, 'Time',
            '${_dateTime.hour}:${_dateTime.minute}'),
        _infoWidget(Icons.location_on_outlined, 'Address', _address),
      ],
    );
  }
}

Widget _infoWidget(IconData iconData, String topString, String bottomString) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: const Color(0xffFF7700),
            size: Material.defaultSplashRadius,
          ),
          Text(
            topString,
            style: const TextStyle(
                color: Color(0xffFF7700),
                fontSize: Material.defaultSplashRadius),
            textAlign: TextAlign.start,
          ),
        ],
      ),
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
