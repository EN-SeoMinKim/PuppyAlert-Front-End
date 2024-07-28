class FavoriteHostModel {
  late String _hostId;
  late String _recentFoodTime;

  FavoriteHostModel({required String hostId, required String recentFoodTime})
      : _hostId = hostId,
        _recentFoodTime = recentFoodTime;

  factory FavoriteHostModel.fromJson(Map<String, dynamic> json) {
    return FavoriteHostModel(
        hostId: json['hostId'], recentFoodTime: json['recentFoodTime']);
  }

  String get hostId => _hostId;

  String get recentFoodTime => _recentFoodTime;
}
