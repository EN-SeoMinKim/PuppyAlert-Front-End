import 'package:flutter/material.dart';

class FoodMapDetailChildWidget extends StatelessWidget {
  late final String _foodName, _personName, _address;
  late final String _dateTime;

  FoodMapDetailChildWidget(
      String foodName, String personName, String address, String dateTime,
      {super.key}) {
    _foodName = foodName;
    _personName = personName;
    _address = address;
    _dateTime = parsingTime(dateTime);
  }

  String parsingTime(String dateTime) {
    List<String> timeSplit = dateTime.split('T');
    String monthDay =
        '${timeSplit[0].split('-')[1]}/${timeSplit[0].split('-')[2]}';
    String hourMinute =
        '${timeSplit[1].split(':')[0]}:${timeSplit[1].split(':')[1]}';

    return '$monthDay $hourMinute';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                child: Text(
                  "     "+_foodName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(_personName),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
        _infoWidget(Icons.access_time, 'Time', _dateTime),
                SizedBox(height: 20),
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
          SizedBox(width: 20),
          Icon(
            iconData,
            color: const Color(0xffFF7700),
            size: 30,
          ),
          Text(
            topString,
            style: const TextStyle(
                color: Color(0xffFF7700),
                fontSize: 25),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      SizedBox(height: 5),
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
