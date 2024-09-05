import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/common_screens/my_page_common_screen.dart';
import 'home_host_screen.dart';

class MainHostScreen extends StatefulWidget {
  final UserModel _userModel;

  const MainHostScreen({super.key, required userModel}) : _userModel = userModel;

  @override
  State<MainHostScreen> createState() => _MainHostScreenState();
}

class _MainHostScreenState extends State<MainHostScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptionList;

  @override
  void initState() {
    super.initState();
    _widgetOptionList = <Widget>[
      HomeHostScreen(userModel: widget._userModel,),
      // TraditionalMarketMapScreen(),
      // LocalStoreListAdultScreen(),
      MyPageCommonScreen(
        userModel: widget._userModel,
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
            create: (context) => FoodProvider(widget._userModel.userId),
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
