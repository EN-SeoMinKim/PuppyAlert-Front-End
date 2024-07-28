import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import 'package:http/http.dart' as http;

class FoodRegistrationCompletionAdultScreen extends StatefulWidget {
  final String _userId;
  final String _food;
  final String _time;

  const FoodRegistrationCompletionAdultScreen({
    super.key,
    required String userId,
    required String food,
    required String time,
  })  : _userId = userId,
        _food = food,
        _time = time;

  @override
  State<FoodRegistrationCompletionAdultScreen> createState() =>
      _FoodRegistrationCompletionAdultScreenState();
}

class _FoodRegistrationCompletionAdultScreenState
    extends State<FoodRegistrationCompletionAdultScreen> {
  String _imageURL = '';

  @override
  void initState() {
    super.initState();
    _registerFood();
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
    final RegExp hourRegex = RegExp(r'(\d+)시');
    final RegExpMatch? hourMatch = hourRegex.firstMatch(inputTime);

    final RegExp minuteRegex = RegExp(r'(\d+)분');
    final RegExpMatch? minuteMatch = minuteRegex.firstMatch(inputTime);

    final int hour =
        hourMatch != null ? int.parse(hourMatch.group(1) ?? '0') : 0;
    final int minute =
        minuteMatch != null ? int.parse(minuteMatch.group(1) ?? '0') : 0;

    DateTime now = DateTime.now();

    DateTime customDateTime =
        DateTime(now.year, now.month, now.day, hour, minute);
    String formattedDateTime = customDateTime.toIso8601String();

    return formattedDateTime + "Z";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text('똥강아지\n모집완료!',
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
          ElevatedShadowButtonAdultWidget(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {},
              text: "취소"),
        ],
      ),
    );
  }
}
