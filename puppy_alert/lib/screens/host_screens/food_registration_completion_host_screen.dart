import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/widgets/host_widgets/elevated_shadow_button_host_widget.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/widgets/host_widgets/top_white_container_host_widget.dart';

import 'main_host_screen.dart';

class FoodRegistrationCompletionHostScreen extends StatefulWidget {
  final String _userId;
  final String _food;
  final String _time;

  const FoodRegistrationCompletionHostScreen({
    super.key,
    required String userId,
    required String food,
    required String time,
  })  : _userId = userId,
        _food = food,
        _time = time;

  @override
  State<FoodRegistrationCompletionHostScreen> createState() =>
      _FoodRegistrationCompletionHostScreenState();
}

class _FoodRegistrationCompletionHostScreenState
    extends State<FoodRegistrationCompletionHostScreen> {
  late String _imageURL;

  @override
  void initState() {
    super.initState();
    // _registerFood();
    _imageURL = '';
  }

  void _registerFood() async {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/host/food');

    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'hostId': widget._userId,
        'menuName': widget._food,
        'time': _getFormattedDateTime(widget._time),
      }),
    );

    final jsonData = jsonDecode(response.body);
    String imageUrl = jsonData['imageURL'] ?? '';

    setState(() {
      _imageURL = imageUrl;
    });
  }

  void _cancelFoodRegistration() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/host/food');

    http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'hostId': widget._userId,
          'menuName': widget._food,
          'time': _getFormattedDateTime(widget._time),
        }));
  }

  String _getFormattedDateTime(String inputTime) {
    int hour = _getTimeFromTimeInput(inputTime, '시');
    int minute = _getTimeFromTimeInput(inputTime, '분');

    DateTime now = DateTime.now();

    DateTime customDateTime =
        DateTime(now.year, now.month, now.day, hour, minute);
    String formattedDateTime = customDateTime.toIso8601String();

    return "${formattedDateTime}Z";
  }

  int _getTimeFromTimeInput(String inputTime, String timeType) {
    final RegExp regex = RegExp(r'(\d+)' + timeType);
    final RegExpMatch? match = regex.firstMatch(inputTime);
    final int time = match != null ? int.parse(match.group(1) ?? '0') : 0;
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const TopWhiteContainerHostWidget(text: "같이 식사할 사람을\n  모집 중입니다!"),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 270,
                height: 270,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_imageURL.isEmpty)
                            const CircularProgressIndicator(),
                          if (_imageURL.isNotEmpty)
                            Image.network(
                              _imageURL,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.rice_bowl,
                            color: Color(0xffFF7700), size: 30),
                        const SizedBox(width: 15),
                        Text(widget._food,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff6C6C6C)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time,
                            color: Color(0xffFF7700), size: 30),
                        const SizedBox(width: 15),
                        Text(widget._time,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff6C6C6C)))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedShadowButtonHostWidget(
                backgroundColor: const Color(0xffffc2c2),
                textColor: Colors.black,
                onPressed: () {
                  // _cancelFoodRegistration();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                text: "취소",
                height: 100,
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
