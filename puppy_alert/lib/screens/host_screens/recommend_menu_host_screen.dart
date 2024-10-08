import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/recommend_menu_model.dart';
import '../../widgets/host_widgets/top_white_container_host_widget.dart';
import 'recommend_menu_detail_host_screen.dart';
import 'package:http/http.dart' as http;

class RecommendMenuHostScreen extends StatefulWidget {
  const RecommendMenuHostScreen({super.key});

  @override
  State<RecommendMenuHostScreen> createState() =>
      _RecommendMenuHostScreenState();
}

class _RecommendMenuHostScreenState extends State<RecommendMenuHostScreen> {
  final Map<String, List<String>> _menuMap = {
    '카테고리': ['한식', '중식', '일식', '양식'],
    '고기': ['소고기', '돼지고기', '닭고기', '오리고기', '양고기'],
    '채소': ['마늘', '양파', '당근', '감자', '대파', '토마토', '양배추', '버섯'],
  };
  final Map<String, List<bool>> _isCheckedMap = {
    '카테고리': [],
    '고기': [],
    '채소': [],
  };
  int _stepperIndex = 0;

  @override
  void initState() {
    super.initState();
    _menuMap.forEach((key, value) {
      _isCheckedMap[key] = List<bool>.filled(value.length, false);
    });
  }

  Step _stepWidget(String title) {
    return Step(
      title: Text(title, style: const TextStyle(fontSize: 20)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (String value in _menuMap[title]!)
              CheckboxListTile(
                title: Text(value),
                activeColor: const Color(0xffFF7700),
                controlAffinity: ListTileControlAffinity.leading,
                value: _isCheckedMap[title]![_menuMap[title]!.indexOf(value)],
                onChanged: (bool? newValue) {
                  setState(() {
                    _isCheckedMap[title]![_menuMap[title]!.indexOf(value)] =
                        newValue!;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  void _goNextScreen(BuildContext context) async {
    List<String> categoryList = _getCheckedStringList('카테고리');
    List<String> meatList = _getCheckedStringList('고기');
    List<String> vegetableList = _getCheckedStringList('채소');

    _showLoadingDialog(context);

    final jsonDataList =
        await _getJsonDataList(categoryList, meatList, vegetableList);

    Navigator.of(context).pop();

    if (jsonDataList == null) {
      _showFailDialog(context);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommendMenuDetailHostScreen(
          categoryList: _getCheckedStringList('카테고리'),
          meatList: _getCheckedStringList('고기'),
          vegetableList: _getCheckedStringList('채소'),
          recommendMenuList: jsonDataList
              .map<RecommendMenuModel>(
                  (json) => RecommendMenuModel.fromJson(json))
              .toList(),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('추천 메뉴를 가져오는 중입니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: const LinearProgressIndicator(),
        );
      },
    );
  }

  void _showFailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('그런 메뉴는 존재하지 않습니다..',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _getJsonDataList(List<String> categoryList,
      List<String> meatList, List<String> vegetableList) async {
    String ingredients = '${meatList.join(',')},${vegetableList.join(',')}';
    http.Response response = await http.post(
      Uri.parse('${dotenv.env['BASE_URL']}/openai/recommend'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'categoryType': categoryList.first,
        'ingredients': ingredients,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    }

    return null;
  }

  List<String> _getCheckedStringList(String title) {
    List<String> result = [];
    for (int i = 0; i < _isCheckedMap[title]!.length; i++) {
      if (_isCheckedMap[title]![i]) {
        result.add(_menuMap[title]![i]);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai에게 메뉴 추천 받기',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: TopWhiteContainerHostWidget(text: "가지고 계신\n 재료를 선택해주세요!"),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ]),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Color(0xffFF7700),
                              size: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                '재료 선택',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Stepper(
                          connectorColor: WidgetStateProperty.all<Color>(
                              const Color(0xffFF7700)),
                          currentStep: _stepperIndex,
                          onStepCancel: () {
                            if (_stepperIndex > 0) {
                              setState(() {
                                _stepperIndex -= 1;
                              });
                            }
                          },
                          onStepContinue: () {
                            if (_stepperIndex > 1) {
                              _goNextScreen(context);
                            } else {
                              setState(() {
                                _stepperIndex += 1;
                              });
                            }
                          },
                          onStepTapped: (int index) {
                            setState(() {
                              _stepperIndex = index;
                            });
                          },
                          steps: <Step>[
                            _stepWidget('카테고리'),
                            _stepWidget('고기'),
                            _stepWidget('채소'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
