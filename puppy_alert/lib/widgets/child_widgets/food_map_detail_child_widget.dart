import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart';

class FoodMapDetailChildWidget extends StatefulWidget {
  final String foodName, personName;
  final NLatLng latLng;
  final DateTime dateTime;

  const FoodMapDetailChildWidget({
    super.key,
    required this.foodName,
    required this.personName,
    required this.latLng,
    required this.dateTime,
  });

  @override
  State<FoodMapDetailChildWidget> createState() =>
      _FoodMapDetailChildWidgetState();
}

class _FoodMapDetailChildWidgetState extends State<FoodMapDetailChildWidget> {
  late String _address = "Loading...";

  @override
  void initState() {
    super.initState();

    _getAddress(widget.latLng).then((address) {
      setState(() {
        _address = address;
      });
    });
  }

  Future<String> _getAddress(NLatLng latLng) async {
    Response response = await _getResponse(latLng);
    String jsonData = response.body;
    print(jsonData);
    return jsonData;
  }

  Future<Response> _getResponse(NLatLng latLng) async {
    String id = dotenv.get('CLIENT_ID');
    String secret = dotenv.get('CLIENT_SECRET');
    Map<String, String> header = {
      'X-NCP-APIGW-API-KEY-ID': id,
      'X-NCP-APIGW-API-KEY': secret
    };

    return await get(
        Uri.parse(
            'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=${latLng.longitude},${latLng.latitude}&orders=roadaddr&output=json'),
        headers: header);
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
                padding: const EdgeInsets.fromLTRB(0, 0, 100.0, 0),
                child: Text(
                  widget.foodName,
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
                    Text(widget.personName),
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
            '${widget.dateTime.hour}:${widget.dateTime.minute}'),
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
