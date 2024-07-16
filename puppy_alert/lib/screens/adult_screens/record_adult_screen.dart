import 'package:flutter/material.dart';
import '../../widgets/adult_widgets/elevated_shadow_button.dart';

class RecordAdultScreen extends StatefulWidget {
  const RecordAdultScreen({super.key});

  @override
  _RecordAdultScreenState createState() => _RecordAdultScreenState();
}

class _RecordAdultScreenState extends State<RecordAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
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
              child: ElevatedShadowButton(
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
