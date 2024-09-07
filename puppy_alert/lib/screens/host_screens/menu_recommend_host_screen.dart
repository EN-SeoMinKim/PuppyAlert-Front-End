import 'package:flutter/material.dart';
import 'package:puppy_alert/models/recommend_menu_dto.dart';

import 'menu_detail_host_screen.dart';

class MenuRecommendHostScreen extends StatefulWidget {
  const MenuRecommendHostScreen({super.key});

  @override
  State<MenuRecommendHostScreen> createState() =>
      _MenuRecommendHostScreenState();
}

class _MenuRecommendHostScreenState extends State<MenuRecommendHostScreen> {
  final RecommendMenuDTO _categoryDTO =
      RecommendMenuDTO('카테고리', ['한식', '중식', '일식', '양식', '기타']);
  final RecommendMenuDTO _meatDTO =
      RecommendMenuDTO('고기', ['소고기', '돼지고기', '닭고기', '오리고기', '양고기', '기타']);
  final RecommendMenuDTO _vegetableDTO = RecommendMenuDTO(
      '채소', ['마늘', '양파', '당근', '감자', '대파', '토마토', '양배추', '버섯', '기타']);
  int _stepperIndex = 0;

  Step _stepWidget(RecommendMenuDTO model) {
    return Step(
      title: Text(model.title, style: const TextStyle(fontSize: 20)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: model.valueList.map((value) {
            int index = model.valueList.indexOf(value);

            return CheckboxListTile(
              title: Text(value),
              activeColor: const Color(0xffFF7700),
              controlAffinity: ListTileControlAffinity.leading,
              value: model.isCheckedList[index],
              onChanged: (bool? newValue) {
                setState(() {
                  model.isCheckedList[index] = newValue!;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _goNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailHostScreen(
          categoryList: _categoryDTO.getCheckedStringList(),
          meatList: _meatDTO.getCheckedStringList(),
          vegetableList: _vegetableDTO.getCheckedStringList(),
        ),
      ),
    );
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
                            _stepWidget(_categoryDTO),
                            _stepWidget(_meatDTO),
                            _stepWidget(_vegetableDTO),
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
