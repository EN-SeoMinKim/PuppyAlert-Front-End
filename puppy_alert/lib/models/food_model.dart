class FoodModel {
  late int _id;
  late String _foodName;

  FoodModel({required int id, required String foodName})
      : _foodName = foodName,
        _id = id;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(id: json['id'], foodName: json['name']);
  }
}
