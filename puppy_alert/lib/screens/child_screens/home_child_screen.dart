import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/widgets/child_widgets/search_bar_child_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';

class HomeChildScreen extends StatefulWidget {
  const HomeChildScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeChildScreenState();
}

class _HomeChildScreenState extends State<HomeChildScreen> {
  List<dynamic> _foodList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/food/all');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          _foodList = jsonDecode(utf8.decode(response.bodyBytes));
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarChildWidget(),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: _foodList.length,
            itemBuilder: (BuildContext context, int index) {
              return FoodCommonWidget(
                imagePath: 'assets/bibimbab.jpg',
                foodName: _foodList[index]['menu'],
                hostName: _foodList[index]['hostId'],
                time: _foodList[index]['time'],
                recruitmentStatus: _foodList[index]['status'],
              );
            },
          ),
        ),
      ],
    );
  }
}