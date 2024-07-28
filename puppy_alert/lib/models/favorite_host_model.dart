class FavoriteHostModel {
  late String _hostId;
  late String _recentFoodTime;

  FavoriteHostModel({required String hostId, required String recentFoodTime})
      : _hostId = hostId,
        _recentFoodTime = recentFoodTime;

  factory FavoriteHostModel.fromJson(Map<String, dynamic> json) {
    if (json['recentFoodTime'] == null) {
      return FavoriteHostModel(
        hostId: json['hostId'],
        recentFoodTime: '함꼐 식사한 기록이 없습니다'
      );
    }

    List<String> timeSplit = json['recentFoodTime'].split('T');
    String monthDay =
        '${timeSplit[0].split('-')[1]}/${timeSplit[0].split('-')[2]}';
    String hourMinute =
        '${timeSplit[1].split(':')[0]}:${timeSplit[1].split(':')[1]}';

    json['recentFoodTime'] = '$monthDay $hourMinute';

    return FavoriteHostModel(
        hostId: json['hostId'], recentFoodTime: json['recentFoodTime']);
  }

  String get hostId => _hostId;

  String get recentFoodTime => _recentFoodTime;
}
