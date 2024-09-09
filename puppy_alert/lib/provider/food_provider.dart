import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class FoodProvider with ChangeNotifier {
  final String _userId;
  final List<FoodModel> _foodList = List.empty(growable: true);
  bool _isDisposed = false;

  FoodProvider(this._userId);

  List<FoodModel> getFoodList() {
    _fetchFood();
    return _foodList;
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _fetchFood() async {
    http.Response response = await http.get(Uri.parse('${dotenv.get('BASE_URL')}/puppy/food?puppyId=$_userId'));
    if (response.statusCode != 200) return;

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    List<FoodModel> result = jsonData.map<FoodModel>((json) => FoodModel.fromJson(json)).toList();

    if (_isDisposed) return;

    _foodList.clear();
    _foodList.addAll(result);
    notifyListeners();
  }
}