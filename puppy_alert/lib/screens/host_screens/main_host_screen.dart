import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/market_model.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/screens/common_screens/my_page_common_screen.dart';
import 'package:puppy_alert/screens/host_screens/shop_host_screen.dart';
import 'package:puppy_alert/widgets/host_widgets/market_map_host_widget.dart';
import 'home_host_screen.dart';
import 'package:http/http.dart' as http;

class MainHostScreen extends StatefulWidget {
  final UserModel _userModel;

  const MainHostScreen({super.key, required userModel})
      : _userModel = userModel;

  @override
  State<MainHostScreen> createState() => _MainHostScreenState();
}

class _MainHostScreenState extends State<MainHostScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptionList;

  @override
  void initState() {
    super.initState();

    _initWidgetOptionList([]);

    _getMarketList().then((value) {
      setState(() {
        _initWidgetOptionList(value);
      });
    });
  }

  void _initWidgetOptionList(List<MarketModel> marketList) {
    _widgetOptionList = <Widget>[
      HomeHostScreen(userModel: widget._userModel),
      ShopHostScreen(marketList: marketList),
      MarketMapHostWidget(userLatLng: widget._userModel.userLatLng, marketList: marketList),
      MyPageCommonScreen(userModel: widget._userModel),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<MarketModel>> _getMarketList() async {
    http.Response response =
    await http.get(Uri.parse('${dotenv.get('BASE_URL')}/market/all'));
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonData
        .map<MarketModel>((json) => MarketModel.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: _widgetOptionList.elementAt(_selectedIndex)),
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
