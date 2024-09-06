import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/host_screens/menu_detail_host_screen.dart';

class MenuRecommendHostScreen extends StatefulWidget {
  const MenuRecommendHostScreen({super.key});

  @override
  State<MenuRecommendHostScreen> createState() =>
      _MenuRecommendHostScreenState();
}

class _MenuRecommendHostScreenState extends State<MenuRecommendHostScreen> {
  final Map<String, List<String>> _selectedOptionMap = {
    '카테고리': ['카테고리', '한식', '중식', '일식', '양식', '기타'],
    '고기': ['고기', '소고기', '돼지고기', '닭고기', '오리고기', '양고기', '기타'],
    '채소': ['채소', '마늘', '양파', '당근', '감자', '대파', '토마토', '양배추', '버섯', '기타']
  };
  final List<String> _selectedValueList = ['카테고리', '고기', '채소'];

  Widget _dropdownWidget(String category) {
    if (_selectedOptionMap[category] == null) {
      return const Text('error',
          style: TextStyle(color: Colors.white, fontSize: 20));
    }

    int selectedIndex = _selectedOptionMap.keys.toList().indexOf(category);

    return DropdownButton<String>(
      value: _selectedValueList[selectedIndex],
      elevation: 16,
      style: const TextStyle(fontSize: 15, color: Colors.black),
      dropdownColor: Colors.orange,
      onChanged: (String? newValue) {
        if (newValue != null && newValue != _selectedValueList[selectedIndex]) {
          setState(() {
            _selectedValueList[selectedIndex] = newValue;
          });
        }
      },
      items: _selectedOptionMap[category]!
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai에게 메뉴 추천 받기',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: Column(
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
            padding: const EdgeInsets.all(10.0),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _dropdownWidget('카테고리'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _dropdownWidget('고기'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _dropdownWidget('채소'),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF7700)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuDetailHostScreen(
                                      selectedValueList: _selectedValueList)));
                        },
                        child: const Text('추천 받기',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
