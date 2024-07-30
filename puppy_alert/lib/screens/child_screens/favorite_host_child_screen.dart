import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/models/favorite_host_model.dart';
import 'package:puppy_alert/widgets/child_widgets/favorite_host_child_widget.dart';

class FavoriteHostChildScreen extends StatefulWidget {
  final String _userId;

  const FavoriteHostChildScreen(
      {super.key, required String userId})
      : _userId = userId;

  @override
  State<FavoriteHostChildScreen> createState() =>
      _FavoriteHostChildScreenState();
}

class _FavoriteHostChildScreenState extends State<FavoriteHostChildScreen> {
  List<FavoriteHostModel>? favoriteHostModelList;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteHostList().then((jsonDataList) {
      setState(() {
        favoriteHostModelList = jsonDataList;
      });
    });
  }

  Future<List<FavoriteHostModel>> _fetchFavoriteHostList() async {
    final response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/puppy/favoriteHost?puppyId=${widget._userId}'));
    if (response.body == '최근 집밥을 먹은 적이 없습니다') {
      return [];
    }

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return jsonData.map((json) => FavoriteHostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Widget getShowWidget() {
    if (favoriteHostModelList == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (favoriteHostModelList!.isEmpty) {
      return const Center(
          child: Text(
            '설정한 관심 HOST가 없습니다',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ));
    }
    return Expanded(
        child: ListView.builder(
          itemCount: favoriteHostModelList!.length,
          itemBuilder: (context, index) {
            return FavoriteHostChildWidget(
              hostId: favoriteHostModelList![index].hostId,
              puppyId: widget._userId,
              recentFoodTime: favoriteHostModelList![index].recentFoodTime,
              isFavorite: true,
            );
          },
        ));
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
        getShowWidget(),
      ],
    );
  }
}