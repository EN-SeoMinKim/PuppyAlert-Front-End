import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/puppy_screens/favorite_host_puppy_screen.dart';
import 'package:puppy_alert/screens/puppy_screens/home_puppy_screen.dart';
import 'package:puppy_alert/screens/common_screens/my_page_common_screen.dart';
import 'food_map_puppy_screen.dart';

class MainPuppyScreen extends StatefulWidget {
  final UserModel _userModel;

  const MainPuppyScreen({super.key, required userModel}) : _userModel = userModel;

  @override
  State<MainPuppyScreen> createState() => _MainPuppyScreenState();
}

class _MainPuppyScreenState extends State<MainPuppyScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptionList;

  @override
  void initState() {
    super.initState();
    _widgetOptionList = <Widget>[
      HomePuppyScreen(
          userDongAddress: widget._userModel.dongAddress,
          userId: widget._userModel.userId),
      FoodMapPuppyScreen(
        userModel: widget._userModel,
      ),
      FavoriteHostPuppyScreen(userId: widget._userModel.userId),
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
