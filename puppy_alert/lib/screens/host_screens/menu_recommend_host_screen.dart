import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/host_screens/menu_detail_host_screen.dart';
import 'package:puppy_alert/widgets/host_widgets/check_box_dialog_host_widget.dart';

class MenuRecommendHostScreen extends StatefulWidget {
  const MenuRecommendHostScreen({super.key});

  @override
  State<MenuRecommendHostScreen> createState() =>
      _MenuRecommendHostScreenState();
}

class _MenuRecommendHostScreenState extends State<MenuRecommendHostScreen> {
  final Map<String, List<String>> _selectedOptionMap = {
    '카테고리': ['한식', '중식', '일식', '양식', '기타'],
    '고기': ['소고기', '돼지고기', '닭고기', '오리고기', '양고기', '기타'],
    '채소': ['마늘', '양파', '당근', '감자', '대파', '토마토', '양배추', '버섯', '기타']
  };
  final List<CheckBoxDialogHostWidget> _checkBoxDialogList = [];
  int _stepperIndex = 0;

  @override
  void dispose() {
    _checkBoxDialogList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _checkBoxDialogList.addAll(_selectedOptionMap.keys    // 똑같은 선택 버튼을 두번 누르면 navigator 오류 발생, 수정 필요
        .map((key) => CheckBoxDialogHostWidget(
              key: UniqueKey(),
              title: key,
              valueList: _selectedOptionMap[key]!,
            ))
        .toList());
  }

  Step _stepWidget(String value) {
    return Step(
      title: Text(value, style: const TextStyle(fontSize: 20)),
      content: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFF7700),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _checkBoxDialogList[
                  _selectedOptionMap.keys.toList().indexOf(value)],
            ),
          );
        },
        child: Text('$value 선택',
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  void _goNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailHostScreen(
          categoryList: _checkBoxDialogList[0].getSelectedValueList(),
          meatList: _checkBoxDialogList[1].getSelectedValueList(),
          vegetableList: _checkBoxDialogList[2].getSelectedValueList(),
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
              padding: const EdgeInsets.all(100.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  color: Colors.blue,
                  child: const Center(
                      child: Text('김지원', style: TextStyle(fontSize: 20))),
                ),
              ),
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
