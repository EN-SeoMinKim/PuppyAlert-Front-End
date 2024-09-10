import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/models/favorite_host_model.dart';
import 'package:puppy_alert/widgets/puppy_widgets/favorite_host_puppy_widget.dart';

class FavoriteHostpuppyScreen extends StatefulWidget {
  final String _userId;

  const FavoriteHostpuppyScreen({super.key, required String userId})
      : _userId = userId;

  @override
  State<FavoriteHostpuppyScreen> createState() =>
      _FavoriteHostpuppyScreenState();
}

class _FavoriteHostpuppyScreenState extends State<FavoriteHostpuppyScreen> {
  List<FavoriteHostModel>? _favoriteHostModelList;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteHostList();
  }

  void _fetchFavoriteHostList() async {
    final response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/puppy/favoriteHost?puppyId=${widget._userId}'));
    if (response.body == '최근 집밥을 먹은 적이 없습니다') {
      return;
    }

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      setState(() {
        _favoriteHostModelList =
            jsonData.map((json) => FavoriteHostModel.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 100.0,
          child: Center(
            child: Text(
              '관심 HOST',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[200]!, width: 2.0),
          ),
        ),
        _getShowWidget(_favoriteHostModelList, widget._userId),
      ],
    );
  }
}

Widget _getShowWidget(
    List<FavoriteHostModel>? favoriteHostList, String userId) {
  if (favoriteHostList == null) {
    return const Center(child: CircularProgressIndicator());
  } else if (favoriteHostList.isEmpty) {
    return const Center(
        child: Text(
      '설정한 관심 HOST가 없습니다',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    ));
  }
  return Expanded(
      child: ListView.builder(
    itemCount: favoriteHostList.length,
    itemBuilder: (context, index) {
      return FavoriteHostPuppyWidget(
        puppyId: userId,
        favoriteHostModel: favoriteHostList[index],
      );
    },
  ));
}
