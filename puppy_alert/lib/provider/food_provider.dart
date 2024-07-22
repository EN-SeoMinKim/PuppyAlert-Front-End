import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class FoodProvider with ChangeNotifier {
  final List<FoodModel> foodList = List.empty(growable: true);

  List<FoodModel> getFoodList() {
    fetchFood();
    return foodList;
  }

  void fetchFood() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/food/'));
    final List<FoodModel> result = jsonDecode(response.body).map<FoodModel>((json) => FoodModel.fromJson(json)).toList();

    foodList.clear();
    foodList.addAll(result);
    notifyListeners();
  }
}