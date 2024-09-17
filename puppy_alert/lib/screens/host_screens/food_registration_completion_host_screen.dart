import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/provider/partner_and_status_provider.dart';
import 'package:puppy_alert/widgets/host_widgets/elevated_shadow_button_host_widget.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/widgets/host_widgets/top_white_container_host_widget.dart';
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';

class FoodRegistrationCompletionHostScreen extends StatefulWidget {
  final String _userId, _food, _time;

  const FoodRegistrationCompletionHostScreen({
    super.key,
    required String userId,
    food,
    time,
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
  late String? _partnerNickName;
  late int _foodId;

  @override
  void initState() {
    super.initState();
    _registerFood();
    _imageURL = '';
    _foodId = 0;
    _partnerNickName = null;
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
    int foodId = jsonData['foodId'];

    setState(() {
      _imageURL = imageUrl;
      _foodId = foodId;
    });
  }

  void _cancelFoodRegistration() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/host/food');

    http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'foodId': _foodId,
          'userId': widget._userId,
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

  void _showDialog(IconData icon, String mention) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 180,
            width: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    icon,
                    color: Colors.orange,
                    size: 50,
                  ),
                ),
                Text(
                  mention,
                  style: const TextStyle(
                      color: Color(0xff3b3b3b), fontWeight: FontWeight.w800),
                ),
                LongRectangleButtonCommonWidget(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  text: "확인",
                  width: 100,
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ChangeNotifierProvider<PartnerAndStatusProvider>(
            create: (context) => PartnerAndStatusProvider(widget._userId),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Consumer<PartnerAndStatusProvider>(
                    builder: (context, partnerAndStatusProvider, child) {
                  Map<String, String> partnerAndStatus =
                      partnerAndStatusProvider.getPartnerAndStatus();
                  String? partnerNickName = partnerAndStatus['partnerNickName'];
                  String? status = partnerAndStatus['status'];

                  if (status == 'COMPLETE') {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showDialog(Icons.check_circle_outline, "식사 완료!");
                    });
                  }

                  return partnerNickName == ''
                      ? const TopWhiteContainerHostWidget(
                          text: "같이 식사할 사람을\n  모집 중입니다!",
                        )
                      : TopWhiteContainerHostWidget(
                          text: "'${partnerNickName}'과\n좋은 식사시간 보내세요!",
                          coloNumber1: 0xffCEFFF8,
                          colorNumber2: 0xffEACDFF,
                        );
                }),
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
                    _cancelFoodRegistration();
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
      ),
    );
  }
}
