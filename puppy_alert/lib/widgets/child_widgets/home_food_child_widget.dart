import 'package:flutter/material.dart';

class HomeFoodChildWidget extends StatefulWidget {
  const HomeFoodChildWidget({super.key});

  @override
  State<HomeFoodChildWidget> createState() => _HomeFoodChildWidgetState();
}

class _HomeFoodChildWidgetState extends State<HomeFoodChildWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/bibimbab.jpg',
              width: 100,
            ),
          ),
        ),
        Column(
          children: [
            const Text(
              '비빔밥',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Row(
              children: [
                Text('김순옥님'),
                Icon(Icons.favorite_border, color: Colors.red,)
              ],
            ),
            const Text('18:00'),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.yellow,
              child:const Text('똥강아지 모집완료'),
            )
          ],
        ),
      ],
    );
  }
}
