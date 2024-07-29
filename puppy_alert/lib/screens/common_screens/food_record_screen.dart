import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
import '../../widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import 'package:http/http.dart' as http;

class FoodRecordScreen extends StatefulWidget {
  final String _userId;
  final bool _isChildScreen;

  const FoodRecordScreen(
      {super.key, required bool isChildScreen, required userId})
      : _userId = userId,
        _isChildScreen = isChildScreen;

  @override
  State<FoodRecordScreen> createState() => _FoodRecordScreenState();
}

class _FoodRecordScreenState extends State<FoodRecordScreen> {
  late List<FoodCommonWidget> _foodCommonWidget;

  @override
  void initState() {
    super.initState();
    _foodCommonWidget = List.empty(growable: true);

    getJsonData().then((jsonData) {
      for (var data in jsonData) {
        _foodCommonWidget.add(FoodCommonWidget(
            userId: widget._userId,
            imagePath: data['imageURL'],
            foodName: data['menuName'],
            hostName: data['partnerId'],
            time: data['time'],
            recruitmentStatus: 'MATCHED'));
      }
    });
  }

  Future<dynamic> getJsonData() async {
    Uri uri;
    if (widget._isChildScreen) {
      uri = Uri.parse(
          '${dotenv.get('BASE_URL')}/puppy/history?puppyId=${widget._userId}');
    } else {
      uri = Uri.parse(
          '${dotenv.get('BASE_URL')}/host/history?hostId=${widget._userId}');
    }

    return jsonDecode(utf8.decode((await http.get(uri)).bodyBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 100.0,
              child: Center(
                child: Text(
                  '집밥 기록',
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
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  if (_foodCommonWidget.isEmpty) {
                    return const LinearProgressIndicator();
                  }

                  return _foodCommonWidget[index];
                },
              ),
            ),
            if (!widget._isChildScreen) goBackButton(context),
          ],
        ));
  }
}

Widget goBackButton(BuildContext context) {
  return Container(
    height: 100.0,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey[200]!, width: 2.0),
    ),
    child: Center(
      child: ElevatedShadowButtonAdultWidget(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "뒤로 가기"),
    ),
  );
}
