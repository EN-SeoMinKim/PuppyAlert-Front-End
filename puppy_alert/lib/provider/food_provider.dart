import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class FoodProvider with ChangeNotifier {
  final List<FoodModel> _foodList = List.empty(growable: true);

  List<FoodModel> getFoodList() {
    _fetchFood();
    return _foodList;
  }

  void _fetchFood() async {
    http.Response response = await http.get(Uri.parse('${dotenv.get('BASE_URL')}/food/all'));
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    List<FoodModel> result = jsonData.map<FoodModel>((json) => FoodModel.fromJson(json)).toList();

    _foodList.clear();
    _foodList.addAll(result);
    notifyListeners();
  }
}