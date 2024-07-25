import 'package:flutter/material.dart';
import '../../widgets/child_widgets/favorite_host_child_widget.dart';

class FavoriteHostChildScreen extends StatefulWidget {
  const FavoriteHostChildScreen({super.key});

  @override
  State<FavoriteHostChildScreen> createState() =>
      _FavoriteHostChildScreenState();
}

class _FavoriteHostChildScreenState extends State<FavoriteHostChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: firstHostWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}