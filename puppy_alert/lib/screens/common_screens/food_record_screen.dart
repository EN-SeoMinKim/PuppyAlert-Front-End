import 'package:flutter/material.dart';
import '../../widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';

class FoodRecordScreen extends StatefulWidget {
  final bool _isChildScreen;

  const FoodRecordScreen({super.key, required bool isChildScreen})
      : _isChildScreen = isChildScreen;

  @override
  State<FoodRecordScreen> createState() => _FoodRecordScreenState();
}

class _FoodRecordScreenState extends State<FoodRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: widget._isChildScreen),
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
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
          if (!widget._isChildScreen) goBackButton(context),
        ],
      ),
    );
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
