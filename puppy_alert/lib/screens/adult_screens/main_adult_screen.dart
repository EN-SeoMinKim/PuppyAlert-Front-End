import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/adult_screens/traditional_market_map_screen.dart';
import 'package:puppy_alert/screens/common_screens/my_page_common_screen.dart';
import 'home_adult_screen.dart';
import 'local_store_list_adult_screen.dart';

class MainAdultScreen extends StatefulWidget {
  final UserDto _userDto;

  const MainAdultScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  State<MainAdultScreen> createState() => _MainAdultScreenState();
}

class _MainAdultScreenState extends State<MainAdultScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptionList;

  @override
  void initState() {
    super.initState();
    _widgetOptionList = <Widget>[
      HomeAdultScreen(userId: widget._userDto.userId),
      TraditionalMarketMapScreen(),
      LocalStoreListAdultScreen(),
      MyPageCommonScreen(
        userDto: widget._userDto,
      ),
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
        child: ChangeNotifierProvider<FoodProvider>(
            create: (context) => FoodProvider(widget._userDto.userId),
            child: _widgetOptionList.elementAt(_selectedIndex)),
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
            label: '전통 시장 지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: '지역 상점 리스트',
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
