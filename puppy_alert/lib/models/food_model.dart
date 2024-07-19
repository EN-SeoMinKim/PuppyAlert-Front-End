import 'package:flutter/foundation.dart';

class FoodModel {
  late int id;
  late String foodName;

  FoodModel({required this.id, required this.foodName});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(id: json['id'], foodName: json['name']);
  }
}
