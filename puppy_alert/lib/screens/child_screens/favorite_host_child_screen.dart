import 'package:flutter/material.dart';
import '../../widgets/child_widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/child_widgets/host_widget.dart';

class FavoriteHostAdultScreen extends StatefulWidget {
  const FavoriteHostAdultScreen({super.key});

  @override
  State<FavoriteHostAdultScreen> createState() =>
      _FavoriteHostAdultScreenState();
}

class _FavoriteHostAdultScreenState extends State<FavoriteHostAdultScreen> {
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
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 3,
          onTap: (index) {},
        ));
  }
}
