import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/food_model.dart';
import '../../provider/food_provider.dart';

class TestProviderScreen extends StatefulWidget {
  const TestProviderScreen({super.key});

  @override
  State<TestProviderScreen> createState() => _TestProviderScreenState();
}

class _TestProviderScreenState extends State<TestProviderScreen> {
  late List<FoodModel> _foodList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<FoodProvider>(builder: (context, provider, child) {
          _foodList = provider.getFoodList();

          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                        '${_foodList[index].id}: ${_foodList[index].foodName}'));
              });
        })
    );
  }
}
