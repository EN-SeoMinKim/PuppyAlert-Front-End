import 'package:flutter/material.dart';
import 'menu_detail_host_screen.dart';

class MenuRecommendHostScreen extends StatefulWidget {
  const MenuRecommendHostScreen({super.key});

  @override
  State<MenuRecommendHostScreen> createState() =>
      _MenuRecommendHostScreenState();
}

class _MenuRecommendHostScreenState extends State<MenuRecommendHostScreen> {
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

  void _goNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailHostScreen(
          categoryList: _getCheckedStringList('카테고리'),
          meatList: _getCheckedStringList('고기'),
          vegetableList: _getCheckedStringList('채소'),
        ),
      ),
    );
  }

  List<String> _getCheckedStringList(String title) {
    List<String> result = [];
    for (bool isChecked in _isCheckedMap[title]!) {
      if (isChecked) {
        result.add(_menuMap[title]![_isCheckedMap[title]!.indexOf(isChecked)]);
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
                            offset: const Offset(0, 3))
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
                              _goNextScreen();
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
