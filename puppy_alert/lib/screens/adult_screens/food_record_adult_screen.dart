import 'package:flutter/material.dart';
import '../../widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';

class FoodRecordAdultScreen extends StatefulWidget {
  const FoodRecordAdultScreen({super.key});

  @override
  State<FoodRecordAdultScreen> createState() => _FoodRecordAdultScreenState();
}

class _FoodRecordAdultScreenState extends State<FoodRecordAdultScreen> {
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
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[200]!, width: 2.0),
            ),
            child: Center(
              child: ElevatedShadowButtonAdultWidget(
                  onPressed: () {
                    // Navigator.pop();
                  },
                  text: "뒤로 가기"),
            ),
          ),
        ],
      ),
    );
  }
}
