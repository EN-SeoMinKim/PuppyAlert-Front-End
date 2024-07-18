import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xffFF7700),
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
          label: '관심 어른',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: '나의 정보',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
