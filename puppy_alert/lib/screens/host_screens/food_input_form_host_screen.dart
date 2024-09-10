import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/screens/host_screens/food_registration_completion_host_screen.dart';
import 'package:puppy_alert/widgets/host_widgets/time_picker_spinner_host_widget.dart';
import 'package:puppy_alert/widgets/host_widgets/top_white_container_host_widget.dart';
import 'package:http/http.dart' as http;
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';

class FoodInputFormHostScreen extends StatefulWidget {
  final String _userId;

  const FoodInputFormHostScreen({super.key, required String userId})
      : _userId = userId;

  @override
  State<FoodInputFormHostScreen> createState() => _FoodInputFormHostScreen();
}

class _FoodInputFormHostScreen extends State<FoodInputFormHostScreen> {
  final TextEditingController _menuInputController = TextEditingController();
  late DateTime? _time = null;

  bool _isTimeAndMenuNotNull() {
    return (_time != null && _menuInputController.text
        .trim()
        .isNotEmpty);
  }

  void _clickRegisterButton() {
    if (_isTimeAndMenuNotNull()) {
      _checkMenuName();
      return;
    }
    _showDialog(Icons.warning_amber, "시간과 메뉴를 다시 입력해주세요!", false);
  }

  void _checkMenuName() async {
    Uri uri = Uri.parse(
        '${dotenv.get(
            'BASE_URL')}/openai/checkMenu?menuName=${_menuInputController.text
            .trim()}');
    http.Response response = await http.get(uri);
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));

    if (jsonData.toString() == 'true') {
      return _showDialog(Icons.check_circle_outline, "집밥 등록 완료", true);
    }

    _showDialog(Icons.warning_amber, "메뉴 이름이 아닙니다!", false);
  }

  void _showDialog(IconData icon, String mention, bool isSuccess) {
    showDialog(
        context: context,
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
                  Text(mention,
                      style: const TextStyle(
                          color: Color(0xff3b3b3b),
                          fontWeight: FontWeight.w800)),
                  LongRectangleButtonCommonWidget(
                    onPressed: () {
                      if (isSuccess) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FoodRegistrationCompletionHostScreen(
                                        userId: widget._userId,
                                        food: _menuInputController.text.trim(),
                                        time: _formatTimeToString(_time!))));
                        return;
                      }
                      Navigator.pop(context);
                    },
                    text: "확인",
                    width: 100,
                    height: 30,
                  )
                ],
              ),
            ),
          );
        });
  }

  String _formatTimeToString(DateTime time) {
    return '${time.hour}시${time.minute}분';
  }

  void _initialize() {
    _menuInputController.clear();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 50),
                child: Center(
                  child: TopWhiteContainerHostWidget(text: "식사 등록을\n  해주세요!"),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 40),
                child: Container(
                  height: 280,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3))
                      ]),
                  child: Stack(
                    children: [
                      const Positioned(
                          top: 30,
                          left: 40,
                          child: Icon(Icons.access_time,
                              color: Color(0xffFF7700), size: 30)),
                      const Positioned(
                          top: 32,
                          left: 90,
                          child: Text(
                            "식사시간",
                            style: TextStyle(
                                color: Color(0xff5E5E5E), fontSize: 15),
                          )),
                      Positioned(
                          top: 60,
                          left: 90,
                          child: TimePickerSpinnerHostWidget(
                            selectedTime: (time) {
                              setState(() {
                                if (time != null) {
                                  _time = time;
                                }
                              });
                            },
                          )),
                      const Positioned(
                          top: 120,
                          left: 40,
                          child: Icon(Icons.rice_bowl,
                              color: Color(0xffFF7700), size: 30)),
                      const Positioned(
                          top: 125,
                          left: 90,
                          child: Text(
                            "메뉴",
                            style: TextStyle(
                                color: Color(0xff5E5E5E), fontSize: 15),
                          )),
                      Positioned(
                          top: 145,
                          left: 90,
                          child: SizedBox(
                            width: 100,
                            child: TextField(
                                controller: _menuInputController,
                                decoration: const InputDecoration(
                                    labelText: "  ",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey)))),
                          )),
                      Positioned(
                        top: 200,
                        left: 80,
                        child: LongRectangleButtonCommonWidget(
                          width: 100,
                          height: 35,
                          onPressed: () {
                            _clickRegisterButton();
                          },
                          text: "등록 ",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}


