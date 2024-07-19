import 'dart:async';
import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/child_widgets/food_map_child_widget.dart';

class FoodMapChildScreen extends StatefulWidget {
  const FoodMapChildScreen({super.key});

  @override
  State<FoodMapChildScreen> createState() => _FoodMapChildScreenState();
}

class _FoodMapChildScreenState extends State<FoodMapChildScreen> {
  @override
  Widget build(BuildContext context) {
    return const FoodMapChildWidget();
  }

}