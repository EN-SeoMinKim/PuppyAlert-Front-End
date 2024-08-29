import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/food_common_widget.dart';
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
  final List<FoodCommonWidget> _foodCommonWidgetList =
      List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    _getJsonData().then((jsonData) {
      setState(() {
        for (var data in jsonData) {
          _foodCommonWidgetList.add(
            FoodCommonWidget(
              userId: widget._userId,
              foodModel: FoodModel(
                address: data['address'],
                addressDetail: data['detailAddress'],
                foodId: data['foodId'],
                hostId: data['hostId'],
                hostNickName: data['partnerNickName'],
                imageURL: data['imageURL'],
                locationMap: data['location'],
                menu: data['menuName'],
                status: "Matched",
                time: data['localDateTime'],
              ),
            ),
          );
        }
      });
    });
  }

  Future<dynamic> _getJsonData() async {
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
                itemCount: _foodCommonWidgetList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_foodCommonWidgetList.isEmpty) {
                    return const LinearProgressIndicator();
                  }

                  return _foodCommonWidgetList[index];
                },
              ),
            ),
            if (!widget._isChildScreen) _goBackButton(context),
          ],
        ));
  }
}

Widget _goBackButton(BuildContext context) {
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
