import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/widgets/host_widgets/elevated_shadow_button_host_widget.dart';
import 'package:http/http.dart' as http;

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
    _registerFood();
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
        'status': 'READY',
      }),
    );

    final jsonData = jsonDecode(response.body);
    String imageUrl = jsonData['imageURL'] ?? '';

    setState(() {
      _imageURL = imageUrl;
    });
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text('집밥\n등록 완료!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  color: Colors.red,
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          _imageURL.isNotEmpty
              ? Image.network(_imageURL)
              : const CircularProgressIndicator(),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${widget._food}\n${widget._time}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          ElevatedShadowButtonHostWidget(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.popAndPushNamed(
                    context, 'speech_recognition_adult_screen');
              },
              text: "취소"),
        ],
      ),
    );
  }
}
