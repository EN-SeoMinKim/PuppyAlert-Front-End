import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/favorite_host_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/home_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/my_page_child_screen.dart';

import 'food_map_child_screen.dart';

class MainChildScreen extends StatefulWidget {
  const MainChildScreen({super.key});

  @override
  State<MainChildScreen> createState() => _MainChildScreenState();
}

class _MainChildScreenState extends State<MainChildScreen> {
  late int _selectedIndex;
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _widgetOptions = <Widget>[
      const HomeChildScreen(),
      const FoodMapChildScreen(),
      const FavoriteHostChildScreen(),
      const MyPageChildScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xffFF7700),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '집밥 지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '관심 Host',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: '나의 정보',
          ),
        ],
      ),
    );
  }
}
