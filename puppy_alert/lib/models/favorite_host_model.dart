class FavoriteHostModel {
  late String _hostNickName;
  late String _recentFoodTime;

  FavoriteHostModel({required String hostNickName, required String recentFoodTime})
      : _hostNickName = hostNickName,
        _recentFoodTime = recentFoodTime;

  factory FavoriteHostModel.fromJson(Map<String, dynamic> json) {
    if (json['recentFoodTime'] == null) {
      return FavoriteHostModel(
          hostNickName: json['hostNickName'],
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
        hostNickName: json['hostNickName'], recentFoodTime: json['recentFoodTime']);
  }

  String get hostId => _hostNickName;

  String get recentFoodTime => _recentFoodTime;
}
