import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/models/user_dto.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/child_screens/favorite_host_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/home_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/my_page_child_screen.dart';
import 'food_map_child_screen.dart';

class MainChildScreen extends StatefulWidget {
  final UserDto _userDto;

  const MainChildScreen({super.key, required userDto}) : _userDto = userDto;

  @override
  State<MainChildScreen> createState() => _MainChildScreenState();
}

class _MainChildScreenState extends State<MainChildScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptionList;

  @override
  void initState() {
    super.initState();

    _widgetOptionList = <Widget>[
      HomeChildScreen(
        userAddress: widget._userDto.dongAddress,
        userId:widget._userDto.userId
      ),
      FoodMapChildScreen(
        userDto: widget._userDto,
      ),
      FavoriteHostChildScreen(userId: widget._userDto.userId),
      MyPageChildScreen(userDto: widget._userDto,),
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
            child: _widgetOptionList.elementAt(_selectedIndex)
        ),
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
